<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Settings Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
        <style>
            body {
                background-color: #f8f9fa;
            }
            .table th a {
                text-decoration: none;
                color: inherit;
            }
            .table th a:hover {
                text-decoration: underline;
            }
            .action-buttons a {
                margin-right: 5px;
            }
            .sort-icon {
                color: #ccc;
            }
            .sort-icon.active {
                color: #212529;
            }
            .card {
                border: none;
                border-radius: 0.75rem;
            }
            .add-form-container {
                display: ${showAddForm ? 'block' : 'none'};
            }

            /* CSS để ẩn cột (không đổi) */
            .column-hidden {
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="mb-0">Settings Management</h2>
                <c:choose>
                    <c:when test="${showAddForm}"><a href="settingController" class="btn btn-danger"><i class="fas fa-times me-2"></i>Cancel Adding</a></c:when>
                    <c:otherwise><a href="settingController?action=add" class="btn btn-success"><i class="fas fa-plus me-2"></i>Add New Setting</a></c:otherwise>
                </c:choose>
            </div>

            <%-- Các thông báo success/error (không đổi) --%>
            <c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show" role="alert">${success}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div></c:if>
            <c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show" role="alert"><strong>Error:</strong> ${error}<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div></c:if>

            <%-- Form thêm mới (không đổi) --%>
            <div class="add-form-container mb-4">
                <div class="card shadow-sm"><div class="card-header bg-primary text-white"><h3>Add New Setting</h3></div><div class="card-body p-4"><form action="settingController" method="post"><div class="row"><div class="col-md-6 mb-3"><label for="type" class="form-label fw-bold">Type (Group)</label><input list="setting-types" class="form-control" id="type" name="type" required><datalist id="setting-types"><c:forEach var="t" items="${settingTypes}"><option value="${t}"></option></c:forEach></datalist></div><div class="col-md-6 mb-3"><label for="settingKey" class="form-label fw-bold">Setting Name (Key)</label><input type="text" class="form-control" id="settingKey" name="settingKey" required></div></div><div class="mb-3"><label for="value" class="form-label fw-bold">Value</label><input type="text" class="form-control" id="value" name="value"></div><div class="mb-3"><label for="description" class="form-label fw-bold">Description</label><textarea class="form-control" id="description" name="description" rows="2"></textarea></div><div class="row"><div class="col-md-6 mb-3"><label for="orderNum" class="form-label fw-bold">Order</label><input type="number" class="form-control" id="orderNum" name="orderNum" required></div><div class="col-md-6 mb-3"><label for="status" class="form-label fw-bold">Status</label><select class="form-select" id="status" name="status"><option value="Active" selected>Active</option><option value="Inactive">Inactive</option></select></div></div><div class="d-flex justify-content-end pt-3 border-top"><button type="submit" class="btn btn-primary px-4">Save Setting</button></div></form></div></div>
                </div>

                <div class="card shadow-sm">
                    <div class="card-header bg-light"><i class="fas fa-filter me-2"></i>Filter, Search & View Options</div>
                    <div class="card-body">
                        <form action="settingController" method="get">
                            <div class="row align-items-end">

                                <div class="col-lg-2 col-md-4 mb-3">
                                    <label for="pageSize" class="form-label">Items/Page</label>
                                    <input type="number" class="form-control" id="pageSize" name="pageSize" value="${not empty currentPSize ? currentPSize : 5}">
                            </div>

                            <div class="col-lg-3 col-md-8 mb-3">
                                <label for="search" class="form-label">Search</label>
                                <input type="text" class="form-control" id="search" name="search" value="${currentSearch}">
                            </div>

                            <div class="col-lg-3 col-md-6 mb-3">
                                <label for="filterType" class="form-label">Filter by Type</label>
                                <select class="form-select" id="filterType" name="type">
                                    <option value="all">All</option>
                                    <c:forEach var="t" items="${settingTypes}">
                                        <option value="${t}" ${currentType==t?'selected':''}>${t}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-lg-2 col-md-6 mb-3">
                                <label for="filterStatus" class="form-label">Status</label>
                                <select class="form-select" id="filterStatus" name="status">
                                    <option value="all">All</option>
                                    <option value="Active" ${currentStatus=='Active'?'selected':''}>Active</option>
                                    <option value="Inactive" ${currentStatus=='Inactive'?'selected':''}>Inactive</option>
                                </select>
                            </div>

                            <div class="col-lg-2 col-md-12 mb-3">
                                <button type="submit" class="btn btn-primary w-100">Apply</button>
                            </div>

                        </div>
                    </form>

                    <div id="column-toggler" class="mt-3 border-top pt-3">
                        <strong class="me-3">Show columns:</strong>
                        <%-- THAY ĐỔI: Thêm 'checked' để mặc định là HIỆN CỘT --%>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="hide-id" data-column="id" checked>
                            <label class="form-check-label" for="hide-id">ID</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="hide-type" data-column="type" checked>
                            <label class="form-check-label" for="hide-type">Type</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="hide-value" data-column="value" checked>
                            <label class="form-check-label" for="hide-value">Value</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="hide-order" data-column="order" checked>
                            <label class="form-check-label" for="hide-order">Order</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="checkbox" id="hide-status" data-column="status" checked>
                            <label class="form-check-label" for="hide-status">Status</label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-4 shadow-sm">
                <div class="card-body table-responsive">
                    <%-- Phần bảng không thay đổi, vẫn giữ nguyên các class --%>
                    <table class="table table-hover table-bordered align-middle">
                        <thead class="table-light">
                            <tr>
                        <c:set var="p" value="pageSize=${currentPSize}&search=${currentSearch}&type=${currentType}&status=${currentStatus}" /><c:set var="sI"><i class="fas fa-sort sort-icon ms-1"></i></c:set><c:set var="sA"><i class="fas fa-sort-up sort-icon active ms-1"></i></c:set><c:set var="sD"><i class="fas fa-sort-down sort-icon active ms-1"></i></c:set>
                        <th class="col-id"><a href="settingController?sortBy=settingID&sortOrder=${currentSortBy=='settingID'&&currentSortOrder=='asc'?'desc':'asc'}&${p}">ID${currentSortBy=='settingID'?(currentSortOrder=='asc'?sA:sD):sI}</a></th>
                        <th class="col-type"><a href="settingController?sortBy=type&sortOrder=${currentSortBy=='type'&&currentSortOrder=='asc'?'desc':'asc'}&${p}">Type${currentSortBy=='type'?(currentSortOrder=='asc'?sA:sD):sI}</a></th>
                        <th class="col-value"><a href="settingController?sortBy=value&sortOrder=${currentSortBy=='value'&&currentSortOrder=='asc'?'desc':'asc'}&${p}">Value${currentSortBy=='value'?(currentSortOrder=='asc'?sA:sD):sI}</a></th>
                        <th class="col-order"><a href="settingController?sortBy=ordernum&sortOrder=${currentSortBy=='ordernum'&&currentSortOrder=='asc'?'desc':'asc'}&${p}">Order${currentSortBy=='ordernum'?(currentSortOrder=='asc'?sA:sD):sI}</a></th>
                        <th class="col-status"><a href="settingController?sortBy=status&sortOrder=${currentSortBy=='status'&&currentSortOrder=='asc'?'desc':'asc'}&${p}">Status${currentSortBy=='status'?(currentSortOrder=='asc'?sA:sD):sI}</a></th>
                        <th class="text-center">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty settingsList}"><td colspan="6" class="text-center p-4">No settings found.</td></c:if>
                        <c:forEach var="s" items="${settingsList}">
                            <tr>
                                <td class="col-id">${s.settingID}</td>
                                <td class="col-type">${s.settingKey}</td>
                                <td class="col-value">${s.value}</td>
                                <td class="col-order">${s.orderNum}</td>
                                <td class="col-status"><span class="badge ${s.status=='Active'?'bg-success':'bg-secondary'}">${s.status}</span></td>
                                <td class="text-center action-buttons">


                                    <c:url var="detailsUrl" value="/settingDetailsController">
                                        <c:param name="id" value="${s.settingID}"/>
                                    </c:url>
                                    <%-- Tạo link với icon con mắt --%>
                                    <a href="${detailsUrl}" class="btn btn-sm btn-info" title="View/Edit">
                                        <i class="fas fa-eye"></i>
                                    </a>


                                    <c:choose>

                                        <c:when test="${s.status=='Active'}">
                                            <c:url var="statusUrl" value="/settingController">
                                                <c:param name="action" value="update-status"/>
                                                <c:param name="id" value="${s.settingID}"/>
                                                <c:param name="status" value="Inactive"/>
                                            </c:url>
                                            <a href="${statusUrl}" class="btn btn-sm btn-success" title="Deactivate">
                                                <i class="fas fa-toggle-on"></i>
                                            </a>
                                        </c:when>


                                        <c:otherwise>

                                            <c:url var="statusUrl" value="/settingController">
                                                <c:param name="action" value="update-status"/>
                                                <c:param name="id" value="${s.settingID}"/>
                                                <c:param name="status" value="Active"/>
                                            </c:url>
                                            <a href="${statusUrl}" class="btn btn-sm btn-secondary" title="Activate">
                                                <i class="fas fa-toggle-off"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>

                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <%-- Phân trang (không đổi) --%>
            <c:if test="${totalPages > 1}"><nav class="mt-4"><ul class="pagination justify-content-center"><c:set var="pgP" value="pageSize=${currentPSize}&search=${currentSearch}&type=${currentType}&status=${currentStatus}&sortBy=${currentSortBy}&sortOrder=${currentSortOrder}" /><li class="page-item ${currentPage==1?'disabled':''}"><a class="page-link" href="settingController?page=${currentPage-1}&${pgP}">Previous</a></li><c:forEach begin="1" end="${totalPages}" var="i"><li class="page-item ${currentPage==i?'active':''}"><a class="page-link" href="settingController?page=${i}&${pgP}">${i}</a></li></c:forEach><li class="page-item ${currentPage==totalPages?'disabled':''}"><a class="page-link" href="settingController?page=${currentPage+1}&${pgP}">Next</a></li></ul></nav></c:if>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const toggler = document.getElementById('column-toggler');
                if (!toggler)
                    return;

                const checkboxes = toggler.querySelectorAll('input[type="checkbox"]');

                // Hàm để ẩn/hiện một cột
                function updateColumnVisibility(columnName, isVisible) {
                    const cells = document.querySelectorAll('.col-' + columnName);
                    cells.forEach(cell => {
                        if (isVisible) {
                            cell.classList.remove('column-hidden'); // Hiện cột
                        } else {
                            cell.classList.add('column-hidden'); // Ẩn cột
                        }
                    });
                }

                // Xử lý cho từng checkbox
                checkboxes.forEach(checkbox => {
                    const columnName = checkbox.dataset.column;

                    // 1. Khôi phục trạng thái từ localStorage khi tải trang
                    const savedState = localStorage.getItem('setting_col_hidden_' + columnName);

                    // Nếu trong localStorage lưu là 'true' (tức là đã bị ẩn), thì bỏ check ô này
                    if (savedState === 'true') {
                        checkbox.checked = false;
                    }

                    // 2. Cập nhật hiển thị cột dựa trên trạng thái của checkbox (mặc định hoặc đã khôi phục)
                    updateColumnVisibility(columnName, checkbox.checked);

                    // 3.click để thay đổi và lưu trạng thái
                    checkbox.addEventListener('change', () => {
                        const isVisible = checkbox.checked;
                        updateColumnVisibility(columnName, isVisible);

                        // Lưu trạng thái vào localStorage
                        if (isVisible) {
                            // Nếu cột đang hiện, xóa trạng thái "ẩn" khỏi localStorage
                            localStorage.removeItem('setting_col_hidden_' + columnName);
                        } else {
                            // Nếu cột đang ẩn, lưu trạng thái "ẩn" vào localStorage
                            localStorage.setItem('setting_col_hidden_' + columnName, 'true');
                        }
                    });
                });
            });
        </script>
    </body>
</html>