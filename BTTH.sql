create database test_40phut;
use test_40phut;
-- Tạo bảng Danh mục
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Tạo bảng Bài viết
CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    cat_id INT -- Khóa ngoại liên kết tới categories
);
ALTER TABLE posts ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
UPDATE posts SET created_at = NOW() WHERE created_at IS NULL;

-- Chèn dữ liệu mẫu cho Danh mục
INSERT INTO categories (name) VALUES 
('Công nghệ'),   -- ID: 1
('Đời sống'),    -- ID: 2
('Giáo dục'),    -- ID: 3
('Thể thao'),    -- ID: 4
('Ẩm thực');      -- ID: 5 (Danh mục trống)

-- Chèn dữ liệu mẫu cho Bài viết
INSERT INTO posts (title, cat_id) VALUES 
('Lộ diện iPhone 18', 1),
('AI thay đổi thế giới', 1),
('Cách nấu phở ngon', 2),
('Mẹo học tiếng Anh', 3),
('Bài viết không có danh mục 1', NULL), -- Post mồ côi
('Bài viết không có danh mục 2', NULL); -- Post mồ côi
-- Câu 1: Liệt kê danh sách các bài viết kèm theo tên danh mục của chúng. Chỉ hiển thị những bài viết nào đã được phân loại vào một danh mục cụ thể.
select p.post_id,p.title,p.content,p.cat_id,c.category_id,c.name
from posts p
inner join categories c
on p.cat_id = c.category_id;
-- Câu 2: Hiển thị tất cả các bài viết có trong cơ sở dữ liệu. Với những bài viết chưa được gán danh mục, cột "Tên danh mục" phải hiển thị giá trị NULL.
select 
	p.post_id,
    p.title,
    p.content,
    p.cat_id,
    c.category_id,
    c.name as "Tên danh mục"
from posts p
left join categories c
on p.cat_id = c.category_id;
-- Câu 3: Liệt kê tất cả các danh mục có trong hệ thống, kèm theo tiêu đề các bài viết thuộc danh mục đó (nếu có).
SELECT c.name, p.title
FROM posts p
RIGHT JOIN categories c ON p.cat_id = c.category_id;
-- Câu 4: Tìm ra những bài viết đang ở trạng thái "mồ côi" (những bài viết chưa được đưa vào bất kỳ danh mục nào).
select title
from posts
where cat_id is null;
-- Câu 5: Xuất danh sách các danh mục hiện đang "trống" (những danh mục chưa có bất kỳ bài viết nào được đăng).
SELECT c.name 
FROM categories c
LEFT JOIN posts p ON c.category_id = p.cat_id
WHERE p.post_id IS NULL;
-- Câu 6: Thống kê số lượng bài viết theo từng danh mục. Yêu cầu hiển thị đầy đủ tên tất cả danh mục, danh mục nào không có bài viết thì số lượng phải hiển thị là 0.
SELECT c.name, COUNT(p.post_id) AS total_posts
FROM categories c
LEFT JOIN posts p ON c.category_id = p.cat_id
GROUP BY c.category_id, c.name;
-- Câu 7: Lấy ra danh sách các bài viết kèm tên danh mục, nhưng chỉ lọc ra những bài viết thuộc về các danh mục có tên chứa chữ "Công nghệ".
SELECT p.title, c.name
FROM posts p
JOIN categories c ON p.cat_id = c.category_id
WHERE c.name LIKE '%Công nghệ%';
-- Câu 8: Hiển thị danh sách gồm: Tên danh mục và Tiêu đề bài viết. Kết quả phải bao gồm cả những bài viết chưa có danh mục và những danh mục chưa có bài viết (Sử dụng phép gộp kết quả).
SELECT c.name, p.title
FROM categories c
LEFT JOIN posts p ON c.category_id = p.cat_id
-- union: toán tử dùng để gộp 2 đoạn dùng select thành 1 bảng duy nhất
UNION
SELECT c.name, p.title
FROM posts p
LEFT JOIN categories c ON p.cat_id = c.category_id;
-- Câu 9: Tìm danh mục có số lượng bài viết nhiều nhất. Hiển thị: Tên danh mục và Tổng số bài.
SELECT c.name, COUNT(p.post_id) AS total_posts
FROM categories c
LEFT JOIN posts p ON c.category_id = p.cat_id
GROUP BY c.category_id
ORDER BY total_posts DESC
LIMIT 1;
-- Câu 10: Hiển thị danh sách các bài viết kèm tên danh mục, sắp xếp thứ tự theo Tên danh mục từ A-Z. Nếu trùng tên danh mục thì sắp xếp theo Ngày đăng giảm dần.
SELECT p.title, c.name AS category_name, p.created_at
FROM posts p
LEFT JOIN categories c ON p.cat_id = c.category_id
ORDER BY c.name ASC, p.created_at DESC;




