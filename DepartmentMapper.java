package com.example.train.mapper;

import com.example.train.entity.Department;
import org.apache.ibatis.annotations.*;

import java.util.List;
@Mapper
public interface DepartmentMapper {
    // 获取所有部门
    @Select("SELECT * FROM sys_department WHERE deleted = 0")
    List<Department> getAllDepartments();
    // 根据ID获取部门
    @Select("SELECT * FROM sys_department WHERE id = #{id} AND deleted = 0")
    Department getDepartmentById(Long id);
    // 添加部门
    @Insert("INSERT INTO sys_department(parent_id, dept_name, manager, phone, email, sort, status, create_by) " +
            "VALUES(#{parentId}, #{deptName}, #{manager}, #{phone}, #{email}, #{sort}, #{status}, #{createBy})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int addDepartment(Department department);
    // 更新部门信息
    @Update("UPDATE sys_department SET " +
            "parent_id = #{parentId}, " +
            "dept_name = #{deptName}, " +
            "manager = #{manager}, " +
            "phone = #{phone}, " +
            "email = #{email}, " +
            "sort = #{sort}, " +
            "status = #{status}, " +
            "update_by = #{updateBy} " +
            "WHERE id = #{id} AND deleted = 0")
    int updateDepartment(Department department);
    // 逻辑删除部门
    @Update("UPDATE sys_department SET deleted = 1 WHERE id = #{id}")
    int deleteDepartment(Long id);

    // 检查是否存在子部门
    @Select("SELECT COUNT(*) FROM sys_department WHERE parent_id = #{id} AND deleted = 0")
    int hasChildren(Long id);

    // 检查部门名称是否唯一（同一父部门下）
    @Select("SELECT COUNT(*) FROM sys_department " +
            "WHERE parent_id = #{parentId} AND dept_name = #{deptName} AND deleted = 0 AND id != #{excludeId}")
    int isDeptNameUnique(@Param("parentId") Long parentId,
                         @Param("deptName") String deptName,
                         @Param("excludeId") Long excludeId);

    // 根据父部门ID获取子部门
    @Select("SELECT * FROM sys_department WHERE parent_id = #{parentId} AND deleted = 0 ORDER BY sort")
    List<Department> getChildrenByParentId(Long parentId);

    @Select("SELECT COUNT(*) FROM sys_department WHERE id = #{id} AND status = 1 AND deleted = 0")
    int isDepartmentActive(Long id);
}
