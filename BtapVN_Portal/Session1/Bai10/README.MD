# Mô tả các thực thể và các thuộc tính

## Thực thể Product (Sản phẩm):

- ProductID: Khóa chính, định danh duy nhất cho mỗi sản phẩm.
- ProductName: Tên sản phẩm.
- ProductType: Loại sản phẩm.
- ProductPrice: Giá của sản phẩm.

## Thực thể Warehouse (Kho):

- WarehouseID: Khóa chính, định danh duy nhất cho mỗi kho.
- WarehouseName: Tên kho.
- Address: Địa chỉ kho.

## Thực thể Stock (Tồn kho):

- WarehouseID: Khóa ngoại tham chiếu đến Warehouse(WarehouseID).
- ProductID: Khóa ngoại tham chiếu đến Product(ProductID).
- Quantity: Số lượng tồn kho của sản phẩm tại kho.

## Thực thể Order (Đơn hàng):

- OrderID: Khóa chính, định danh duy nhất cho mỗi đơn hàng.
- OrderDate: Ngày đặt hàng.
- DeliveryDate: Ngày giao hàng.
- TotalAmount: Tổng giá trị đơn hàng.

## Thực thể OrderDetail (Chi tiết đơn hàng):

- OrderID: Khóa ngoại tham chiếu đến Order(OrderID).
- ProductID: Khóa ngoại tham chiếu đến Product(ProductID).
- Quantity: Số lượng sản phẩm trong đơn hàng.
  UnitPrice: Đơn giá của sản phẩm tại thời điểm đặt hàng.

# Sơ đồ ER

- Warehouse ←→ Stock ←→ Product: Mối quan hệ giữa Warehouse và Product là nhiều-nhiều, được quản lý qua bảng liên kết Stock.
- Order ←→ OrderDetail ←→ Product: Mối quan hệ giữa Order và Product là nhiều-nhiều, được quản lý qua bảng liên kết OrderDetail.
- ![alt text](Bai10.png)
