Folder này gồm 2 file:
	1 file maple có phần tính phương trình động học thuận; tính các thành phần 
của phương trình động lực học: trọng tâm; ma trận Jacobian xoay, tịnh tiến; M; C; G.
	1 file simulink tính động lực học ngược, cho q tính torque.
	
Không có phần tính động lực học thuận.

File maple ở đây giống với file maple ở ngoài, nhưng có thêm phần chuyển đổi
các công thức của maple sang matlab phần ma trận M, C, G.

File simulink PTDLHN có thể chạy ngay không cần dùng đến file parameters. 
Vì khi cho đầu vào từ file parameters, chương trình báo lỗi quá nhiều dữ kiện thừa,
nên các thông số robot được để ngay trong hàm PTDLH của simulink.