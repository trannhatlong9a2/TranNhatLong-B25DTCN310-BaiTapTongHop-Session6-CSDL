-- Luồng xử lý đúng :
-- Users (u) -> JOIN -> Bookings (b) -> JOIN -> Hotels (h)
-- Điểm mấu chốt: Khi dùng group by user -> sẽ gộp toàn bộ chỉ tiêu của khách hàng thành 1 dòng
-- Quy trình chống bãy:
-- Vấn đề:Có booking nên bị hoàn tiền -> total_price > 0
-- Lý do sai lầm : having sum () > 0 -> sẽ phải cộng tất cả dữ liệu kể cả dữ liệu rác lại -> tốn thời gian
-- Cộng cả số âm vào -> sai dữ liệu 

-- Cách sửa:
SELECT u.user_name,h.star_rating,SUM(b.total_price) AS total_spent
FROM Users u
JOIN Bookings b 
ON u.user_id = b.user_id
JOIN Hotels h ON b.hotel_id = h.hotel_id
WHERE b.status = 'COMPLETED'AND b.total_price > 0
GROUP BY u.user_id,u.user_name,h.star_rating
HAVING SUM(b.total_price) > 50000000
ORDER BY h.star_rating DESC,total_spent DESC;        