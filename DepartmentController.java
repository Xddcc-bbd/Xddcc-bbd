package com.example.train.Controller;

import com.example.train.entity.Department;
import com.example.train.mapper.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@CrossOrigin
public class DepartmentController {
    @Autowired
    DepartmentMapper departmentMapper;

    @RequestMapping("/get-all")
    public ResponseEntity<List<Department>> getAllDepartments() {
        try {
            List<Department> departments = departmentMapper.getAllDepartments();
            return ResponseEntity.ok(departments);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @RequestMapping("/addDepart")
    public ResponseEntity<?> addDepartment(@RequestBody Department department) {
        try {
            // 必填字段校验
            if (department.getParentId() == 0 ||
                    department.getDeptName() == null || department.getDeptName().isEmpty() ||
                    department.getSort() == 0) {
                return ResponseEntity.badRequest().body("上级部门、部门名称、显示排序不能为空");
            }

            // 部门名称唯一性校验
            if (departmentMapper.isDeptNameUnique(department.getParentId(),
                    department.getDeptName(),
                    0L) > 0) {
                return ResponseEntity.badRequest().body("同一层级下部门名称必须唯一");
            }

            // 设置默认值
            department.setStatus(1); // 默认正常
            department.setCreateTime(LocalDateTime.now());
            department.setCreateBy("admin"); // 实际应从会话获取
            department.setDeleted(0);

            int result = departmentMapper.addDepartment(department);
            if (result > 0) {
                return ResponseEntity.ok("部门添加成功");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("部门添加失败");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("服务器内部错误");
        }
    }

    @RequestMapping("/upDepart")
    public ResponseEntity<?> updateDepartment(
            @PathVariable Long id,
            @RequestBody Department department) {
        try {
            // 必填字段校验
            if (department.getParentId() == 0 ||
                    department.getDeptName() == null || department.getDeptName().isEmpty() ||
                    department.getSort() == 0) {
                return ResponseEntity.badRequest().body("上级部门、部门名称、显示排序不能为空");
            }

            // 部门名称唯一性校验（排除自身）
            if (departmentMapper.isDeptNameUnique(department.getParentId(),
                    department.getDeptName(),
                    id) > 0) {
                return ResponseEntity.badRequest().body("同一层级下部门名称必须唯一");
            }

            department.setId(id);
            department.setUpdateTime(LocalDateTime.now());
            department.setUpdateBy("admin"); // 实际应从会话获取

            int result = departmentMapper.updateDepartment(department);
            if (result > 0) {
                return ResponseEntity.ok("部门更新成功");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("部门更新失败");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("服务器内部错误");
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteDepartment(@PathVariable Long id) {
        try {
            // 检查是否存在子部门
            if (departmentMapper.hasChildren(id) > 0) {
                return ResponseEntity.badRequest().body("存在子部门，无法删除");
            }

            int result = departmentMapper.deleteDepartment(id);
            if (result > 0) {
                return ResponseEntity.ok("部门删除成功");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("部门删除失败");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("服务器内部错误");
        }
    }
}