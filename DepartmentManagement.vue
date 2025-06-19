<template>
  <div class="department-management">
    <!-- 头部区域 -->
    <div class="header">
      <h1>组织管理系统</h1>
      <div class="user-info">
        <el-avatar>{{ user.name.charAt(0) }}</el-avatar>
        <div>
          <div>{{ user.name }} ({{ user.role }})</div>
          <div class="last-login">最后登录: {{ user.lastLogin }}</div>
        </div>
      </div>
    </div>

    <!-- 搜索区域 -->
    <el-card class="search-card">
      <el-form :model="searchForm" inline>
        <el-form-item label="部门名称">
          <el-input v-model="searchForm.deptName" clearable placeholder="输入部门名称" />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="searchForm.status" clearable placeholder="全部">
            <el-option label="正常" :value="0" />
            <el-option label="停用" :value="1" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="loadData">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 操作按钮 -->
<div class="action-bar">
  <div>
    <el-button type="primary" @click="handleAdd">
      <el-icon><plus /></el-icon> 新增部门
    </el-button>
    <el-button @click="toggleExpandAll" style="margin-left: 10px;">
      {{ isAllExpanded ? '折叠全部' : '展开全部' }}
    </el-button>
  </div>

</div>

    <!-- 部门表格 -->
    <el-table
      :data="tableData"
      row-key="id"
      :tree-props="{ children: 'children' }"
      v-loading="loading"
      border
      ref="deptTableRef"
    >
<el-table-column prop="deptName" label="部门名称" width="300" />
  <el-table-column prop="sort" label="排序" width="300" />
  <el-table-column prop="status" label="状态" width="300">
    <template #default="{ row }">
      <el-tag :type="row.status === 0 ? 'success' : 'danger'">
        {{ row.status === 0 ? '正常' : '停用' }}
      </el-tag>
    </template>
  </el-table-column>
  <el-table-column prop="createTime" label="创建时间" min-width="500" />
  <el-table-column label="操作" width="500" fixed="right">
    <template #default="{ row }">
      <el-button size="small" @click="handleEdit(row)">修改</el-button>
      <el-button size="small" type="danger" @click="handleDelete(row)">删除</el-button>
    </template>
  </el-table-column>
    </el-table>

    <!-- 新增/编辑弹窗 -->
    <el-dialog 
      v-model="dialog.visible" 
      :title="dialog.title" 
      width="680px"
      :close-on-click-modal="false"
    >
      <el-form 
        :model="form" 
        :rules="rules" 
        ref="formRef" 
        label-width="100px"
        label-position="right"
      >
        <el-form-item label="上级部门" prop="parentId">
          <el-tree-select
            v-model="form.parentId"
            :data="departmentOptions"
            :props="treeProps"
            check-strictly
            placeholder="选择上级部门"
            class="tree-select"
            clearable
          />
        </el-form-item>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="部门名称" prop="deptName">
              <el-input 
                v-model="form.deptName" 
                placeholder="请输入部门名称" 
                clearable
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="显示排序" prop="sort">
              <el-input-number
                v-model="form.sort"
                :min="0"
                :max="999"
                controls-position="right"
                placeholder="请输入排序"
              />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="负责人" prop="manager">
              <el-input 
                v-model="form.manager" 
                placeholder="请输入负责人" 
                clearable
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="phone">
              <el-input 
                v-model="form.phone" 
                placeholder="请输入联系电话" 
                clearable
              />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="邮箱" prop="email">
              <el-input 
                v-model="form.email" 
                placeholder="请输入邮箱" 
                clearable
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="部门状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio :value="0">正常</el-radio>
                <el-radio :value="1">停用</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>

      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialog.visible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import axios from 'axios'

// 配置API基础URL
const API_BASE_URL = 'http://localhost:8080'

// 用户信息
const user = reactive({
  name: '管理员',
  role: 'admin',
  lastLogin: new Date().toLocaleString()
})

// 搜索表单
const searchForm = reactive({
  deptName: '',
  status: ''
})

// 表格数据
const tableData = ref([])
const loading = ref(false)

// 弹窗控制
const dialog = reactive({
  visible: false,
  title: '新增部门',
  isEdit: false
})

// 表单数据
const form = reactive({
  id: null,
  parentId: null,
  deptName: '',
  manager: '',
  phone: '',
  email: '',
  sort: 0,
  status: 0
})

// 表单验证规则
const rules = {
  deptName: [{ required: true, message: '请输入部门名称', trigger: 'blur' }],
  parentId: [{ required: true, message: '请选择上级部门', trigger: 'change' }],
  sort: [{ required: true, message: '请输入显示排序', trigger: 'blur' }]
}

// 部门树数据
const departmentOptions = ref([])
const treeProps = {
  value: 'id',
  label: 'deptName',
  children: 'children'
}

// 统计信息
const stats = computed(() => {
  const active = tableData.value.filter(d => d.status === 0).length
  const inactive = tableData.value.filter(d => d.status === 1).length
  return { active, inactive, total: active + inactive }
})

// 新增：表格ref和展开/折叠全部功能
const deptTableRef = ref(null)
const isAllExpanded = ref(false)

const toggleExpandAll = () => {
  if (!deptTableRef.value) return
  isAllExpanded.value = !isAllExpanded.value
  expandOrCollapseAll(tableData.value, isAllExpanded.value)
}

function expandOrCollapseAll(data, expand) {
  data.forEach(row => {
    deptTableRef.value.toggleRowExpansion(row, expand)
    if (row.children && row.children.length > 0) {
      expandOrCollapseAll(row.children, expand)
    }
  })
}

// 加载部门数据
const loadData = async () => {
  loading.value = true
  try {
    const params = {
      deptName: searchForm.deptName
    }
    if (searchForm.status !== '' && searchForm.status !== null && searchForm.status !== undefined) {
      params.status = searchForm.status
    }
    const response = await axios.get(`${API_BASE_URL}/search-dept`, { params })
    const flatData = response.data

    // 搜索时平铺，不搜索时树形
    if (searchForm.deptName) {
      tableData.value = flatData
    } else {
      const rootDept = flatData.find(item => item.deptName === '测盟会')
      const buildTree = (parentId) => {
        return flatData
          .filter(item => item.parentId === parentId)
          .map(item => ({
            ...item,
            children: buildTree(item.id)
          }))
      }
      tableData.value = rootDept ? [{
        ...rootDept,
        children: buildTree(rootDept.id)
      }] : []
    }
    buildDepartmentTree()
  } catch (error) {
    ElMessage.error(error.response?.data?.message || '查询失败')
  } finally {
    loading.value = false
  }
}

// 构建部门树形选项
const buildDepartmentTree = () => {
  // 添加根节点
  departmentOptions.value = [
    { id: 0, deptName: '根部门', children: [] }
  ]
  
  // 递归构建树形结构
  const buildTree = (parentId, nodes) => {
    const children = tableData.value.filter(item => item.parentId === parentId)
    if (children.length > 0) {
      nodes.push(...children.map(item => ({
        ...item,
        children: buildTree(item.id, [])
      })))
    }
    return nodes
  }
  
  departmentOptions.value[0].children = buildTree(0, [])
}

// 重置搜索
const resetSearch = () => {
  searchForm.deptName = ''
  searchForm.status = ''
  loadData()
}

// 新增部门
const handleAdd = () => {
  dialog.title = '新增部门'
  dialog.isEdit = false
  dialog.visible = true
  Object.assign(form, {
    id: null,
    parentId: 1,
    deptName: '',
    manager: '',
    phone: '',
    email: '',
    sort: 0,
    status: 0
  })
}

// 编辑部门
const handleEdit = (row) => {
  dialog.title = '编辑部门'
  dialog.isEdit = true
  dialog.visible = true
  Object.assign(form, { ...row })
}

// 删除部门
const handleDelete = async (row) => {
  try {
    await ElMessageBox.confirm(`确定删除 ${row.deptName} 吗？`, '警告', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    // 修改为使用/delete-dept接口
    await axios.get(`${API_BASE_URL}/delete-dept?id=${row.id}`)
    ElMessage.success('删除成功')
    loadData()
  } catch (error) {
    if (error !== 'cancel') {
      // 直接显示后端返回的错误信息
      const errorMsg = error.response?.data?.message || 
                     error.response?.data?.error || 
                     '删除失败'
      ElMessage.error(errorMsg)
    }
  }
}

// 提交表单
const handleSubmit = async () => {
  try {
    if (dialog.isEdit) {
      // 修改为使用/update-dept接口
      await axios.post(`${API_BASE_URL}/update-dept`, form)
      ElMessage.success('修改成功')
    } else {
      // 修改为使用/add-dept接口
      await axios.post(`${API_BASE_URL}/add-dept`, form)
      ElMessage.success('新增成功')
    }
    dialog.visible = false
    loadData()
  } catch (error) {
    // 直接显示后端返回的错误信息
    const errorMsg = error.response?.data?.message || 
                   error.response?.data?.error || 
                   '操作失败'
    ElMessage.error(errorMsg)
  }
}

// 初始化加载
onMounted(() => {
  loadData()
})
</script>

<style scoped>
.department-management {
  padding: 20px;
}
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}
.user-info {
  display: flex;
  align-items: center;
  gap: 10px;
}
.last-login {
  font-size: 12px;
  color: #888;
}
.search-card {
  margin-bottom: 20px;
}
.action-bar {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
}
.stats {
  display: flex;
  gap: 10px;
}
.tree-select {
  width: 100%;
}
</style>