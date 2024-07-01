# README
## Database for QLSach_31211024087

### Overview

This project sets up a database named `QLSach_31211024087` to manage a book store's inventory, including categories, publishers, books, authors, customers, employees, and orders. It also includes sample data and a few queries and functions to interact with the database.

### Database Schema

The database schema consists of the following tables:

1. **TheLoai**: Manages book categories.
    - `MaTL`: Category ID (Primary Key)
    - `TenTL`: Category Name

2. **NhaXB**: Manages publishers.
    - `MaXB`: Publisher ID (Primary Key)
    - `TenXB`: Publisher Name
    - `DiaChi`: Address
    - `SDT`: Phone Number
    - `email`: Email

3. **Sach**: Manages books.
    - `MaSach`: Book ID (Primary Key)
    - `TenSach`: Book Title
    - `SoTrang`: Number of Pages
    - `NgayXB`: Publication Date
    - `MaTL`: Category ID (Foreign Key)
    - `MaXB`: Publisher ID (Foreign Key)

4. **TacGia**: Manages authors.
    - `MaTG`: Author ID (Primary Key)
    - `TenTG`: Author Name
    - `DiaChi`: Address
    - `SDT`: Phone Number
    - `email`: Email

5. **Sach_TacGia**: Manages the many-to-many relationship between books and authors.
    - `MaTG`: Author ID (Foreign Key)
    - `MaSach`: Book ID (Foreign Key)

6. **KhachHang**: Manages customers.
    - `MaKH`: Customer ID (Primary Key)
    - `HoKH`: Customer Last Name
    - `TenKH`: Customer First Name
    - `Phone`: Phone Number
    - `Email`: Email

7. **NhanVien**: Manages employees.
    - `MaNV`: Employee ID (Primary Key)
    - `HotenNV`: Employee Name
    - `GT`: Gender
    - `NS`: Date of Birth
    - `MaNVQL`: Manager ID (Foreign Key, references itself)

8. **DonDatHang**: Manages orders.
    - `SoDH`: Order Number (Primary Key)
    - `NgayDH`: Order Date
    - `TrangThaiDH`: Order Status
    - `MaKH`: Customer ID (Foreign Key)
    - `NgayDuKienGiao`: Expected Delivery Date
    - `NgayThucTeGiao`: Actual Delivery Date
    - `MaNV`: Employee ID (Foreign Key)

9. **ChiTietDonHang**: Manages order details.
    - `SoDH`: Order Number (Foreign Key)
    - `MaSach`: Book ID (Foreign Key)
    - `SoLuong`: Quantity
    - `GiaTien`: Price
    - `GiamGia`: Discount

### Sample Data

The sample data includes entries for each table, such as book categories, publishers, books, authors, customers, employees, and orders. Here is an example of inserting a book:

```sql
insert into Sach values(N'THDC',N'Tin học đại cương',N'20','01/01/2020',N'TH',N'NXBTH');
```

### Queries and Functions

#### Queries

1. **List of Customers Without Orders**:
    ```sql
    SELECT DISTINCT KH.MaKH, (KH.HoKH + ' ' + KH.TenKH) AS 'Họ Và Tên', KH.Phone, KH.Email
    FROM dbo.KhachHang KH
    WHERE (KH.MaKH NOT IN (SELECT DISTINCT ddh.MaKH FROM dbo.DonDatHang ddh))
    AND KH.Email NOT LIKE '%@ueh.edu.vn'
    ```

2. **Order Details with Total Amount**:
    ```sql
    SELECT bang2.SoDH, bang2.ndh AS 'Ngày Đặt Hàng', SUM(ttt) AS 'Tổng thành tiền', SUM(ttgg) AS 'Tổng Tiền Giảm Giá', SUM(tt) AS 'Tổng thu'
    FROM (
        SELECT ddh.SoDH, CONVERT(VARCHAR, ddh.NgayDH, 105) AS ndh,
        ctdh.SoLuong * ctdh.GiaTien AS ttt,
        ctdh.SoLuong * ctdh.GiaTien * ctdh.GiamGia AS ttgg,
        ctdh.SoLuong * ctdh.GiaTien * (1 - ctdh.GiamGia) AS tt
        FROM dbo.DonDatHang ddh, dbo.ChiTietDonHang ctdh, dbo.Sach s
        WHERE (ddh.SoDH = ctdh.SoDH) AND (ddh.TrangThaiDH = 1) AND (ctdh.MaSach = s.MaSach)
    ) bang2
    GROUP BY bang2.soDH, bang2.ndh
    HAVING SUM(ttt) > 200000
    ```

3. **Pending Orders Details**:
    ```sql
    SELECT ChiTietDonHang.SoDH, CONVERT(VARCHAR, NgayDH, 105) AS 'Ngày đặt hàng', TrangThaiDH, s.TenSach, (SoLuong * GiaTien) AS 'Thành Tiền', (SoLuong * GiaTien * GiamGia) AS 'Tiền giảm giá'
    FROM dbo.Sach s INNER JOIN dbo.ChiTietDonHang ON ChiTietDonHang.MaSach = s.MaSach INNER JOIN
    dbo.DonDatHang ON DonDatHang.SoDH = ChiTietDonHang.SoDH
    WHERE (TrangThaiDH = 0)
    ```

#### Functions

1. **Total Revenue for Discounted Orders**:
    ```sql
    create function TongDoanhThuHDGiamGia(@sodh nvarchar(10))
    returns table
    as
    return
    (
        select CTDH.SoDH, sum(CTDH.Soluong * CTDH.GiaTien * (1 - CTDH.GiamGia)) N'Tổng doanh thu'
        from ChiTietDonHang CTDH
        where CTDH.SoDH = @sodh
        group by CTDH.SoDH
    )

    select * 
    from dbo.TongDoanhThuHDGiamGia('001')
    ```

2. **Delete Author Procedure**:
    ```sql
    create procedure deleteTG(@maTG char(10))
    as
    if (exists(select MaTG from TacGia where MaTG=@maTG))
    begin
        delete TacGia
        where MaTG = @maTG

        delete Sach_TacGia
        where MaTG = @maTG

        print N'Tác giả đã được xóa'
    end
    else
    begin
        print N'Tác giả không tồn tại'
    end
    ```

### Instructions

1. **Database Creation**:
    ```sql
    create database QLSach_31211024087;
    use QLSach_31211024087;
    ```

2. **Table Creation**:
    Execute the provided SQL scripts to create the tables.

3. **Insert Sample Data**:
    Insert the sample data into the tables.

4. **Run Queries and Functions**:
    Execute the provided queries and functions to interact with the database.

### Notes

- Make sure to follow the provided structure and naming conventions.
- Validate data types and constraints as per the schema.
- Test the queries and functions with different data to ensure correctness.

This database setup helps in managing a bookstore's operations efficiently, providing necessary functionalities to handle books, authors, publishers, customers, employees, and orders.
