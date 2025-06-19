USE CourseManagementDB


-- 1. Bảng Role
INSERT INTO Role (roleName)
VALUES
    (N'Customer'),
    (N'Marketing'),
    (N'Sale'),
    (N'Expert'),
    (N'Admin');


-- 2. Bảng User
INSERT INTO [User] (fullName, email, password, gender, mobile, roleID, avatar, status, address)
VALUES
    (N'Nguyễn Văn An', 'nguyenvanan@gmail.com', 'hashed_123', N'Male', '0912345678', 1, N'https://peticon.edu.vn/wp-content/uploads/2023/10/meo_ragdoll2.jpeg', 'Active', N'123 Đường Láng, Đống Đa, Hà Nội'),
    (N'Trần Thị Bích', 'tranthibich@gmail.com', 'hashed_456', N'Female', '0923456789', 1, N'https://sacomvet.com/upload/news/avatar-cute-meo-3606.jpg', 'Active', N'456 Nguyễn Trãi, Thanh Xuân, Hà Nội'),
    (N'Lê Minh Châu', 'leminhchau@gmail.com', 'hashed_789', N'Male', '0934567890', 1, N'https://tropicpet.vn/wp-content/uploads/2025/02/meo-tai-cup.jpg', 'Inactive', N'789 Phố Huế, Hai Bà Trưng, Hà Nội'),
    (N'Phạm Thị Duyên', 'phamthiduyen@gmail.com', 'hashed_234', N'Female', '0945678901', 1, N'https://fagopet.vn/storage/gt/z7/gtz7ubptmk07841tdwln504hfkfc_phoi-giong-meo-tai-cup.webp', 'Inactive', N'101 Hồ Tùng Mậu, Cầu Giấy, Hà Nội'),
    (N'Hoàng Văn Đạt', 'hoangvandat@gmail.com', 'hashed_567', N'Male', '0956789012', 1, N'https://cdn2.fptshop.com.vn/unsafe/Uploads/images/tin-tuc/168364/Originals/meme-con-meo%20(1).jpg', 'Active', N'202 Kim Mã, Ba Đình, Hà Nội'),
    (N'Vũ Thị Hà', 'vuthiha@gmail.com', 'hashed_890', N'Female', '0967890123', 1, N'https://tapchithucung.vn/Uploads/images/nhung-giong-cho-it-bi-benh.jpg', 'Active', N'303 Trần Duy Hưng, Cầu Giấy, Hà Nội'),
    (N'Đặng Văn Hùng', 'dangvanhung@gmail.com', 'hashed_321', N'Male', '0978901234', 1, N'https://fagopet.vn/storage/v7/ch/v7che47zyux8lz9vxk918t4ok0nn_phoi-giong-cho-phoc-soc.webp', 'Active', N'404 Giải Phóng, Hoàng Mai, Hà Nội'),
    (N'Bùi Thị Lan', 'buithilan@gmail.com', 'hashed_654', N'Female', '0989012345', 1, N'https://www.giaonhan247.com/wp-content/uploads/2024/03/Kieng-nuoi-3-con-cho-kieng-nuoi-2-con-cho-1-1-jpg.webp', 'Inactive', N'505 Láng Hạ, Đống Đa, Hà Nội'),
    (N'Ngô Văn Minh', 'ngovanminh@gmail.com', 'hashed_987', N'Male', '0990123456', 1, N'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/11/20/975861/5-Giong-Cho-Long-Xu-.jpg', 'Active', N'606 Thái Hà, Đống Đa, Hà Nội'),
    (N'Lý Thị Ngọc', 'lythingoc@gmail.com', 'hashed_432', N'Female', '0911234567', 1, N'https://laputafarm.com/wp-content/uploads/2023/06/Yeu-to-anh-huong-toi-gia-cho-Poodle.jpg', 'Active', N'707 Chùa Bộc, Đống Đa, Hà Nội'),
    (N'Trương Văn Phong', 'truongvanphong@gmail.com', 'hashed_765', N'Male', '0922345678', 1, N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/avatar_vo_tri_a49436c5de.jpg', 'Active', N'808 Đường 3/2, Quận 10, TP.HCM'),
    (N'Hà Thị Quyên', 'hathiquyen@gmail.com', 'hashed_198', N'Female', '0933456789', 1, N'https://yeudialy.edu.vn/upload/2025/02/avatar-vo-tri-meo-01.webp', 'Active', N'909 Lê Văn Sỹ, Quận 3, TP.HCM'),
    (N'Đỗ Văn Sơn', 'dovanson@gmail.com', 'hashed_531', N'Male', '0944567890', 1, N'https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/08/13/356/avatar-vo-tri-meo-1.jpg', 'Active', N'111 Võ Văn Tần, Quận 3, TP.HCM'),
    (N'Mai Thị Thảo', 'maithithao@gmail.com', 'hashed_864', N'Female', '0955678901', 1, N'https://bareskin.vn/wp-content/uploads/2025/04/avatar-vo-tri-36.jpg', 'Active', N'222 Hoàng Diệu, Hải Châu, Đà Nẵng'),
    (N'Phan Văn Thành', 'phanvanthanh@gmail.com', 'hashed_297', N'Male', '0966789012', 1, N'https://heucollege.edu.vn/upload/2025/03/cho-vo-tri.webp', 'Active', N'333 Ngô Quyền, Sơn Trà, Đà Nẵng'),
    (N'Nguyễn Thị Uyên', 'nguyenthiuyen@gmail.com', 'hashed_630', N'Female', '0977890123', 1, N'https://peticon.edu.vn/wp-content/uploads/2023/10/meo_ragdoll2.jpeg', 'Active', N'444 Hùng Vương, Ninh Kiều, Cần Thơ'),
    (N'Lê Văn Vinh', 'levanvinh@gmail.com', 'hashed_963', N'Male', '0988901234', 1, N'https://sacomvet.com/upload/news/avatar-cute-meo-3606.jpg', 'Active', N'555 Phan Văn Trị, Gò Vấp, TP.HCM'),
    (N'Trần Thị Xuân', 'tranthixuan@gmail.com', 'hashed_396', N'Female', '0999012345', 1, N'https://tropicpet.vn/wp-content/uploads/2025/02/meo-tai-cup.jpg', 'Active', N'666 Cộng Hòa, Tân Bình, TP.HCM'),
    (N'Phạm Văn Ý', 'phamvany@gmail.com', 'hashed_729', N'Male', '0910123456', 1, N'https://fagopet.vn/storage/gt/z7/gtz7ubptmk07841tdwln504hfkfc_phoi-giong-meo-tai-cup.webp', 'Active', N'777 Xô Viết Nghệ Tĩnh, Bình Thạnh, TP.HCM'),
    (N'Võ Thị Ánh', 'vothianh@gmail.com', 'hashed_162', N'Female', '0921234567', 1, N'https://cdn2.fptshop.com.vn/unsafe/Uploads/images/tin-tuc/168364/Originals/meme-con-meo%20(1).jpg', 'Active', N'888 Bến Vân Đồn, Quận 4, TP.HCM'),
    (N'Bùi Văn Đức', 'buivanduc@gmail.com', 'hashed_333', N'Male', '0932345678', 2, N'https://tapchithucung.vn/Uploads/images/nhung-giong-cho-it-bi-benh.jpg', 'Active', N'999 Lạc Long Quân, Tây Hồ, Hà Nội'),
    (N'Nguyễn Thị Hoa', 'nguyenthihoa@gmail.com', 'hashed_444', N'Female', '0943456789', 2, N'https://fagopet.vn/storage/v7/ch/v7che47zyux8lz9vxk918t4ok0nn_phoi-giong-cho-phoc-soc.webp', 'Active', N'1010 Xuân Thủy, Cầu Giấy, Hà Nội'),
    (N'Trần Văn Khang', 'tranvankhang@gmail.com', 'hashed_555', N'Male', '0954567890', 3, N'https://www.giaonhan247.com/wp-content/uploads/2024/03/Kieng-nuoi-3-con-cho-kieng-nuoi-2-con-cho-1-1-jpg.webp', 'Active', N'1111 Lê Lai, Quận 1, TP.HCM'),
    (N'Lê Thị Linh', 'lethilinh@gmail.com', 'hashed_666', N'Female', '0965678901', 3, N'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/11/20/975861/5-Giong-Cho-Long-Xu-.jpg', 'Active', N'1212 Nguyễn Thị Minh Khai, Quận 1, TP.HCM'),
    (N'Phạm Văn Nam', 'phamvannam@gmail.com', 'hashed_777', N'Male', '0976789012', 4, N'https://laputafarm.com/wp-content/uploads/2023/06/Yeu-to-anh-huong-toi-gia-cho-Poodle.jpg', 'Active', N'1313 Bạch Đằng, Bình Thạnh, TP.HCM'),
    (N'Vũ Thị Oanh', 'vuthioanh@gmail.com', 'hashed_888', N'Female', '0987890123', 4, N'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/avatar_vo_tri_a49436c5de.jpg', 'Active', N'1414 Đào Duy Từ, Thanh Khê, Đà Nẵng'),
    (N'Nguyễn Văn Phúc', 'nguyenvanphuc@gmail.com', 'hashed_999', N'Male', '0998901234', 5, N'https://yeudialy.edu.vn/upload/2025/02/avatar-vo-tri-meo-01.webp', 'Active', N'1515 Hoàng Cầu, Đống Đa, Hà Nội'),
    (N'Trần Thị Quỳnh', 'tranthiquynh@gmail.com', 'hashed_101', N'Female', '0919012345', 5, N'https://cdn.kona-blue.com/upload/kona-blue_com/post/images/2024/08/13/356/avatar-vo-tri-meo-1.jpg', 'Active', N'1616 Tràng Tiền, Hoàn Kiếm, Hà Nội');


-- 3. Bảng PostCategory
INSERT INTO PostCategory (postCategoryName, description)
VALUES
    (N'Web Development', N'Bài viết về phát triển web'),
    (N'Artificial Intelligence', N'Bài viết về trí tuệ nhân tạo'),
    (N'Data Science', N'Bài viết về khoa học dữ liệu'),
    (N'Programming Languages', N'Bài viết về ngôn ngữ lập trình'),
    (N'Software Engineering', N'Bài viết về kỹ thuật phần mềm');


-- 4. Bảng Post
INSERT INTO Post (ownerID, title, postCategoryID, thumbnail, briefInfo, description, status, feature, createDate, updateDate)
VALUES
    (21, N'Top 5 Web Frameworks in 2025', 1, N'image1.jpg', N'Discover the best frameworks for web development.', N'Web development in 2025 is dominated by frameworks that prioritize speed, scalability, and developer experience...', 'Active', 1, '2025-05-15', '2025-05-20'),
    (21, N'Why Learn Full-Stack Development?', 1, N'image2.jpg', N'Unlock career opportunities with full-stack skills.', N'Full-stack development is a gateway to versatile tech careers, blending front-end and back-end expertise...', 'Inactive', 0, '2025-05-16', '2025-05-21'),
    (21, N'Building Responsive Websites', 1, N'image3.jpg', N'Master techniques for mobile-friendly designs.', N'Responsive web design is critical in 2025, with mobile traffic dominating global internet usage...', 'Active', 0, '2025-05-17', '2025-05-22'),
    (22, N'AI Trends Shaping 2025', 2, N'image4.jpg', N'Explore the future of artificial intelligence.', N'Artificial intelligence is transforming industries in 2025, from healthcare to finance...', 'Active', 1, '2025-05-15', '2025-05-20'),
    (21, N'Getting Started with Neural Networks', 2, N'image5.jpg', N'Learn the basics of AI model building.', N'Neural networks are the backbone of modern AI, mimicking human brain functions to solve complex problems...', 'Inactive', 0, '2025-05-16', '2025-05-21'),
    (22, N'AI in Everyday Applications', 2, N'image6.jpg', N'How AI powers daily tech experiences.', N'AI is embedded in daily life in 2025, enhancing convenience and efficiency...', 'Active', 0, '2025-05-17', '2025-05-22'),
    (21, N'Data Science Tools for 2025', 3, N'image7.jpg', N'Top tools for data analysis and visualization.', N'Data science thrives on powerful tools in 2025, streamlining analysis and insights...', 'Active', 1, '2025-05-15', '2025-05-20'),
    (22, N'Why Data Visualization Matters', 3, N'image8.jpg', N'Turn data into compelling stories.', N'Data visualization transforms raw numbers into actionable insights in 2025...', 'Active', 0, '2025-05-16', '2025-05-21'),
    (21, N'Big Data Challenges in 2025', 3, N'image9.jpg', N'Overcome obstacles in data management.', N'Big data in 2025 presents opportunities and challenges for organizations...', 'Active', 0, '2025-05-17', '2025-05-22'),
    (22, N'Why Python Dominates in 2025', 4, N'image10.jpg', N'Explore Python’s versatility in coding.', N'Python remains the top programming language in 2025, thanks to its simplicity and versatility...', 'Active', 1, '2025-05-15', '2025-05-20'),
    (21, N'Java vs. Python: Which to Learn?', 4, N'image11.jpg', N'Compare two powerful languages.', N'Choosing between Java and Python in 2025 depends on career goals...', 'Active', 0, '2025-05-16', '2025-05-21'),
    (22, N'Emerging Languages to Watch', 4, N'image12.jpg', N'Discover the future of programming.', N'In 2025, new programming languages are gaining traction for specialized needs...', 'Active', 0, '2025-05-17', '2025-05-22'),
    (21, N'Agile Practices for 2025', 5, N'image13.jpg', N'Boost efficiency with Agile methods.', N'Agile methodologies are essential for software development in 2025, emphasizing flexibility and collaboration...', 'Active', 1, '2025-05-15', '2025-05-20'),
    (22, N'Mastering Git for Teams', 5, N'image14.jpg', N'Streamline collaboration with version control.', N'Git is the cornerstone of collaborative software development in 2025...', 'Active', 0, '2025-05-16', '2025-05-21'),
    (21, N'Software Architecture Trends', 5, N'image15.jpg', N'Design scalable systems for the future.', N'Software architecture in 2025 prioritizes scalability, resilience, and maintainability...', 'Active', 0, '2025-05-17', '2025-05-22');


-- 5. Bảng CourseCategory
INSERT INTO CourseCategory (courseCategoryName)
VALUES
    (N'Web Development'),
    (N'Artificial Intelligence & Machine Learning'),
    (N'Data Science & Analytics'),
    (N'Programming Languages'),
    (N'Software Engineering & Tools');


-- 6. Bảng Course
INSERT INTO Course (courseName, courseCategoryID, description, ownerID, status, numberOfLesson, feature, createDate)
VALUES
    (N'Full-Stack Web Development', 1, N'Learn to build modern web applications...', 25, 'Active', 5, 1, '2025-01-01'),
    (N'AI with TensorFlow & PyTorch', 2, N'Dive into AI with hands-on projects...', 25, 'Active', 3, 1, '2025-02-01'),
    (N'Data Science with Python & Spark', 3, N'Master data analysis with Python...', 25, 'Active', 3, 1, '2025-03-01'),
    (N'Mastering Python & Java', 4, N'Learn Python and Java for versatile programming...', 25, 'Active', 13, 0, '2025-04-01'),
    (N'Software Architecture with Git', 5, N'Design scalable systems with modern software architecture...', 25, 'Active', 3, 1, '2025-05-01'),
    (N'Cloud Computing Essentials', 5, N'Tìm hiểu các nguyên tắc cơ bản về điện toán đám mây và triển khai.', 26, 'Active', 3, 1, '2025-05-10'),
    (N'Mobile App Development with Flutter', 1, N'Xây dựng ứng dụng di động đa nền tảng với Flutter.', 26, 'Active', 4, 1, '2025-05-12'),
    (N'Cybersecurity Fundamentals', 5, N'Giới thiệu về bảo mật hệ thống và mạng.', 26, 'Inactive', 4, 1, '2025-05-15'),
    (N'Blockchain Technology Basics', 2, N'Khám phá các khái niệm và ứng dụng của công nghệ blockchain.', 26, 'Inactive', 4, 0, '2025-05-18'),
    (N'Advanced Data Visualization', 3, N'Tạo các trực quan hóa dữ liệu nâng cao để khám phá thông tin chi tiết.', 26, 'Inactive', 4, 1, '2025-05-20');


-- 7. Bảng Lesson
INSERT INTO Lesson (courseID, name, contentHtml, contentVideo, type, orderNum, status, topicID, duration)
VALUES
    -- Full-Stack Web Development (courseID = 1)
    (1, N'Chapter 1: Introduction to Full-Stack', NULL, NULL, 'Subject Topic', 1, 'Active', NULL, 0),
    (1, N'Lesson 1.1: React & Front-End Basics', N'<h1>React Basics</h1><p>Learn the fundamentals of React...</p>', N'https://example.com/react-video.mp4', 'Lesson', 1, 'Active', 1, 960),
    (1, N'Lesson 1.2: Node.js & Back-End APIs', N'<h1>Node.js Basics</h1><p>Build APIs with Node.js...</p>', N'https://example.com/node-video.mp4', 'Lesson', 2, 'Active', 1, 960),
    (1, N'Chapter 1 Quiz', NULL, NULL, 'Quiz', 3, 'Active', 1, 600),
    (1, N'Chapter 2: Advanced Full-Stack', NULL, NULL, 'Subject Topic', 2, 'Active', NULL, 0),
    -- AI with TensorFlow & PyTorch (courseID = 2)
    (2, N'Chapter 1: AI Basics', NULL, NULL, 'Subject Topic', 1, 'Active', NULL, 0),
    (2, N'Lesson 1.1: Neural Networks Fundamentals', N'<h1>Neural Networks</h1><p>Understand neural network architecture...</p>', N'https://example.com/nn-video.mp4', 'Lesson', 1, 'Active', 6, 960),
    (2, N'Chapter 1 Quiz', NULL, NULL, 'Quiz', 2, 'Active', 6, 600),
    -- Data Science with Python & Spark (courseID = 3)
    (3, N'Chapter 1: Data Science Basics', NULL, NULL, 'Subject Topic', 1, 'Active', NULL, 0),
    (3, N'Lesson 1.1: Data Analysis with Python', N'<h1>Data Analysis</h1><p>Analyze data using Python libraries...</p>', N'https://example.com/data-video.mp4', 'Lesson', 1, 'Active', 9, 960),
    (3, N'Chapter 1 Quiz', NULL, NULL, 'Quiz', 2, 'Active', 9, 600),
    -- Mastering Python & Java (courseID = 4)
    (4, N'Chapter 1: Programming Basics', NULL, NULL, 'Subject Topic', 1, 'Active', NULL, 0),
    (4, N'Lesson 1.1: Python Programming Basics', N'<h1>Python Basics</h1><p>Learn Python syntax and structure...</p>', N'https://www.youtube.com/embed/7m5HXQbcWCw', 'Lesson', 1, 'Active', 12, 960),
    (4, N'Lesson 1.2: Python Data Structures', N'<h1>Python Data Structures</h1><p>Explore lists, dictionaries, and more...</p>', N'https://www.youtube.com/embed/UxovJz0ppqA', 'Lesson', 2, 'Active', 12, 960),
    (4, N'Chapter 1 Quiz', NULL, NULL, 'Quiz', 3, 'Active', 12, 600),
    (4, N'Chapter 2: Advanced Python Concepts', NULL, NULL, 'Subject Topic', 2, 'Active', NULL, 0),
    (4, N'Lesson 2.1: Python Decorators', N'<h1>Python Decorators</h1><p>Learn how to use decorators...</p>', N'https://www.youtube.com/embed/_W1Rnljx1SY', 'Lesson', 1, 'Active', 16, 960),
    (4, N'Lesson 2.2: Python Generators', N'<h1>Python Generators</h1><p>Understand generator functions...</p>', N'https://www.youtube.com/embed/3s1r_g_jXNs', 'Lesson', 2, 'Active', 16, 960),
    (4, N'Chapter 3: Java Core Principles', NULL, NULL, 'Subject Topic', 3, 'Active', NULL, 0),
    (4, N'Lesson 3.1: Java Syntax Basics', N'<h1>Java Syntax</h1><p>Learn Java syntax and basics...</p>', N'https://www.youtube.com/embed/h9hdorPqukU', 'Lesson', 1, 'Active', 19, 960),
    (4, N'Lesson 3.2: Java Collections', N'<h1>Java Collections</h1><p>Explore Java collections framework...</p>', N'https://www.youtube.com/embed/JLd09jmEAYA', 'Lesson', 2, 'Active', 19, 960),
    (4, N'Chapter 4: Object-Oriented Programming', NULL, NULL, 'Subject Topic', 4, 'Active', NULL, 0),
    (4, N'Lesson 4.1: OOP Concepts in Python', N'<h1>OOP in Python</h1><p>Understand OOP in Python...</p>', N'https://www.youtube.com/embed/NaE40w3riSQ', 'Lesson', 1, 'Active', 22, 960),
    (4, N'Lesson 4.2: OOP Concepts in Java', N'<h1>OOP in Java</h1><p>Understand OOP in Java...</p>', N'https://www.youtube.com/embed/nSDgHBxUbVQ', 'Lesson', 2, 'Active', 22, 960),
    -- Software Architecture with Git (courseID = 5)
    (5, N'Chapter 1: Design Overview', NULL, NULL, 'Subject Topic', 1, 'Active', NULL, 0),
    (5, N'Lesson 1.1: Software Architecture Design', N'<h1>Design</h1><p>Design scalable systems...</p>', N'https://example.com/arch-video.mp4', 'Lesson', 1, 'Active', 25, 960),
    (5, N'Chapter 1 Quiz', NULL, NULL, 'Quiz', 2, 'Active', 25, 600),
    -- Cloud Computing Essentials (courseID = 6)
    (6, N'Chapter 1: Cloud Computing Basics', NULL, NULL, 'Subject Topic', 1, 'Active', NULL, 0),
    (6, N'Lesson 1.1: Cloud Service Models', N'<h1>Service Models</h1><p>Explore IaaS, PaaS, SaaS...</p>', N'https://example.com/cloud-models-video.mp4', 'Lesson', 1, 'Active', 28, 960),
    (6, N'Chapter 1 Quiz', NULL, NULL, 'Quiz', 2, 'Active', 28, 600),
    -- Mobile App Development with Flutter (courseID = 7)
    (7, N'Chapter 1: Introduction to Mobile Development', NULL, NULL, 'Subject Topic', 1, 'Active', NULL, 0),
    (7, N'Lesson 1.1: Flutter Basics', N'<h1>Flutter Basics</h1><p>Start with Flutter development...</p>', N'https://example.com/flutter-intro.mp4', 'Lesson', 1, 'Active', 31, 960),
    (7, N'Lesson 1.2: Building UI with Flutter', N'<h1>UI Building</h1><p>Create UI with Flutter widgets...</p>', N'https://example.com/flutter-ui.mp4', 'Lesson', 2, 'Active', 31, 960),
    (7, N'Chapter 1 Quiz', NULL, NULL, 'Quiz', 3, 'Active', 31, 600),
    -- Cybersecurity Fundamentals (courseID = 8)
    (8, N'Chapter 1: Security Overview', NULL, NULL, 'Subject Topic', 1, 'Inactive', NULL, 0),
    (8, N'Lesson 1.1: Cybersecurity Principles', N'<h1>Principles</h1><p>Learn core security principles...</p>', N'https://example.com/cyber-principles.mp4', 'Lesson', 1, 'Inactive', 35, 960),
    (8, N'Lesson 1.2: Network Security Basics', N'<h1>Network Security</h1><p>Understand network security basics...</p>', N'https://example.com/network-sec.mp4', 'Lesson', 2, 'Inactive', 35, 960),
    (8, N'Chapter 1 Quiz', NULL, NULL, 'Quiz', 3, 'Inactive', 35, 600),
    -- Blockchain Technology Basics (courseID = 9)
    (9, N'Chapter 1: Introduction to Blockchain', NULL, NULL, 'Subject Topic', 1, 'Inactive', NULL, 0),
    (9, N'Lesson 1.1: Blockchain Fundamentals', N'<h1>Fundamentals</h1><p>Explore blockchain technology...</p>', N'https://example.com/blockchain-intro.mp4', 'Lesson', 1, 'Inactive', 39, 960),
    (9, N'Lesson 1.2: Smart Contracts', N'<h1>Smart Contracts</h1><p>Learn smart contract development...</p>', N'https://example.com/smart-contracts.mp4', 'Lesson', 2, 'Inactive', 39, 960),
    (9, N'Chapter 1 Quiz', NULL, NULL, 'Quiz', 3, 'Inactive', 39, 600),
    -- Advanced Data Visualization (courseID = 10)
    (10, N'Chapter 1: Visualization Basics', NULL, NULL, 'Subject Topic', 1, 'Inactive', NULL, 0),
    (10, N'Lesson 1.1: Advanced Visualization Techniques', N'<h1>Advanced Techniques</h1><p>Master advanced visualization techniques...</p>', N'https://example.com/adv-viz.mp4', 'Lesson', 1, 'Inactive', 43, 960),
    (10, N'Lesson 1.2: Interactive Visualizations', N'<h1>Interactive Visualizations</h1><p>Create interactive data visualizations...</p>', N'https://example.com/interactive-viz.mp4', 'Lesson', 2, 'Inactive', 43, 960),
    (10, N'Chapter 1 Quiz', NULL, NULL, 'Quiz', 3, 'Inactive', 43, 600);


-- 8. Bảng Quiz
INSERT INTO Quiz (lessonID, name, courseID, level, numQuestions, duration, passRate, quizType)
VALUES
    (4, N'Full-Stack Quiz', 1, 1, 20, 60, 70.00, N'Lesson-Quiz'),
    (8, N'AI Quiz', 2, 2, 20, 60, 75.00, N'Lesson-Quiz'),
    (11, N'Data Science Quiz', 3, 1, 20, 60, 70.00, N'Lesson-Quiz'),
    (15, N'Programming Quiz', 4, 1, 20, 60, 70.00, N'Lesson-Quiz'),
    (27, N'Software Engineering Quiz', 5, 2, 20, 60, 70.00, N'Lesson-Quiz'),
    (30, N'Cloud Quiz', 6, 1, 20, 60, 70.00, N'Lesson-Quiz'),
    (34, N'Flutter Quiz', 7, 1, 20, 60, 70.00, N'Lesson-Quiz'),
    (38, N'Cybersecurity Quiz', 8, 1, 20, 60, 70.00, N'Lesson-Quiz'),
    (42, N'Blockchain Quiz', 9, 1, 20, 60, 70.00, N'Lesson-Quiz'),
    (46, N'Visualization Quiz', 10, 1, 20, 60, 70.00, N'Lesson-Quiz');


-- 9. Bảng SubjectDimention
INSERT INTO SubjectDimension (courseID, type, name, description)
VALUES
    -- dimensionID = 1: Web Development Basics (courseID = 1)
    (1, N'Theory', N'Web Development Basics', N'Fundamental concepts of web development, including React and HTTP methods.'),
    -- dimensionID = 2: Not used in Question table, but keeping for consistency
    (1, N'Practical', N'Web Development Practice', N'Hands-on web development exercises.'),
    -- dimensionID = 3: Neural Networks (courseID = 2)
    (2, N'Theory', N'Neural Networks', N'Core concepts of neural networks in artificial intelligence.'),
    -- dimensionID = 4: Data Analysis Tools (courseID = 3)
    (3, N'Tools', N'Data Analysis Tools', N'Tools and libraries used for data analysis, such as Pandas in Python.'),
    -- dimensionID = 5: Python Fundamentals (courseID = 4)
    (4, N'Programming', N'Python Fundamentals', N'Basic concepts of Python programming, including syntax, data structures, and operators.'),
    -- dimensionID = 6: Java Fundamentals (courseID = 4)
    (4, N'Programming', N'Java Fundamentals', N'Basic concepts of Java programming, including syntax, variables, arrays, and loops.'),
    -- dimensionID = 7: Software Architecture Principles (courseID = 5)
    (5, N'Design', N'Software Architecture Principles', N'Core principles of software architecture design.'),
    -- dimensionID = 8: Cloud Computing Basics (courseID = 6)
    (6, N'Theory', N'Cloud Computing Basics', N'Fundamental concepts of cloud computing, including service models like IaaS.'),
    -- dimensionID = 9: Not used in Question table, but keeping for consistency
    (7, N'Practical', N'Flutter Development', N'Practical Flutter app development.'),
    -- dimensionID = 10: Flutter Basics (courseID = 7)
    (7, N'Theory', N'Flutter Basics', N'Core concepts of Flutter app development, focusing on widgets.'),
    -- dimensionID = 11: Network Security Basics (courseID = 8)
    (8, N'Theory', N'Network Security Basics', N'Fundamental steps and concepts for securing networks.'),
    -- dimensionID = 12: Blockchain Fundamentals (courseID = 9)
    (9, N'Theory', N'Blockchain Fundamentals', N'Core principles of blockchain technology.');

-- 10. Bảng Question
INSERT INTO Question (courseID, lessonID, dimensionID, content, media, explanation, level, status)
VALUES
    (1, 4, 1, N'What is the primary role of React in web development?', NULL, N'React is a JavaScript library for building user interfaces.', 1, 'Active'),
    (1, 4, 1, N'Which HTTP method is used to retrieve data from a server?', NULL, N'GET is used to retrieve data.', 1, 'Active'),
    (2, 8, 3, N'What is a neural network?', NULL, N'A neural network is a series of algorithms that mimic the human brain.', 2, 'Active'),
    (3, 11, 4, N'Which Python library is used for data analysis?', NULL, N'Pandas is commonly used for data analysis.', 1, 'Active'),
    -- Python Questions (dimensionID = 5)
    (4, 15, 5, N'What is the correct syntax to print "Hello World" in Python?', NULL, N'The correct syntax is print("Hello World").', 1, 'Active'),
    (4, 15, 5, N'Which keyword is used to define a function in Python?', NULL, N'The keyword "def" is used to define a function.', 1, 'Active'),
    (4, 15, 5, N'What is the output of the expression: 3 + 5 * 2 in Python?', NULL, N'The output is 13 because multiplication (*) has higher precedence than addition (+).', 1, 'Active'),
    (4, 15, 5, N'How do you create a list in Python?', NULL, N'A list is created using square brackets, e.g., my_list = [1, 2, 3].', 1, 'Active'),
    (4, 15, 5, N'What does the len() function do in Python?', NULL, N'The len() function returns the length of an object, such as a list or string.', 1, 'Active'),
    (4, 15, 5, N'Which of the following is a valid variable name in Python?', NULL, N'Variable names in Python must start with a letter or underscore and cannot start with a number.', 1, 'Active'),
    (4, 15, 5, N'What is the output of the following code: x = 10; print(x + 5)?', NULL, N'The output is 15 because x is 10 and 10 + 5 = 15.', 1, 'Active'),
    (4, 15, 5, N'How do you add an element to the end of a list in Python?', NULL, N'The append() method adds an element to the end of a list.', 1, 'Active'),
    (4, 15, 5, N'What is the difference between a tuple and a list in Python?', NULL, N'A tuple is immutable (cannot be changed), while a list is mutable.', 2, 'Active'),
    (4, 15, 5, N'What does the "in" operator do in Python?', NULL, N'The "in" operator checks if a value exists in a sequence (like a list or string).', 1, 'Active'),
    -- Java Questions (dimensionID = 6)
    (4, 15, 6, N'What is the correct syntax to print "Hello World" in Java?', NULL, N'The correct syntax is System.out.println("Hello World");.', 1, 'Active'),
    (4, 15, 6, N'Which keyword is used to define a class in Java?', NULL, N'The keyword "class" is used to define a class in Java.', 1, 'Active'),
    (4, 15, 6, N'What is the default value of an int variable in Java?', NULL, N'The default value of an int variable in Java is 0.', 1, 'Active'),
    (4, 15, 6, N'How do you declare an array in Java?', NULL, N'An array is declared using square brackets, e.g., int[] myArray = new int[5];.', 1, 'Active'),
    (4, 15, 6, N'What is the purpose of the "public static void main" method in Java?', NULL, N'It is the entry point of a Java program.', 1, 'Active'),
    (4, 15, 6, N'Which of the following is a valid variable name in Java?', NULL, N'Variable names in Java must start with a letter, underscore, or dollar sign and cannot start with a number.', 1, 'Active'),
    (4, 15, 6, N'What is the output of the following code: int x = 5; System.out.println(x + 3)?', NULL, N'The output is 8 because x is 5 and 5 + 3 = 8.', 1, 'Active'),
    (4, 15, 6, N'What does the "new" keyword do in Java?', NULL, N'The "new" keyword is used to create an object or allocate memory.', 1, 'Active'),
    (4, 15, 6, N'What is the difference between "==" and ".equals()" in Java?', NULL, N'"==" compares object references, while ".equals()" compares the content of objects.', 2, 'Active'),
    (4, 15, 6, N'What does the "for" loop do in Java?', NULL, N'The "for" loop is used to iterate over a range of values or a collection.', 1, 'Active'),
    (5, 27, 7, N'What is the purpose of software architecture?', NULL, N'It provides a blueprint for a system.', 2, 'Active'),
    (6, 30, 8, N'What does IaaS stand for?', NULL, N'Infrastructure as a Service.', 1, 'Active'),
    (7, 34, 10, N'What is the main component of a Flutter app?', NULL, N'Widgets are the main components.', 1, 'Active'),
    (8, 38, 11, N'What is the first step in securing a network?', NULL, N'Identifying vulnerabilities.', 1, 'Active'),
    (9, 42, 12, N'What is a blockchain?', NULL, N'A decentralized ledger technology.', 1, 'Active');

-- 11. Bảng AnswerQuestion
INSERT INTO AnswerOption (questionID, content, isCorrect)
VALUES
    -- Question 1: What is the primary role of React in web development?
    (1, N'A JavaScript library for building user interfaces', 1),
    (1, N'A server-side framework', 0),
    (1, N'A database management tool', 0),
    (1, N'A CSS preprocessor', 0),
    -- Question 2: Which HTTP method is used to retrieve data from a server?
    (2, N'GET', 1),
    (2, N'POST', 0),
    (2, N'PUT', 0),
    (2, N'DELETE', 0),
    -- Question 3: What is a neural network?
    (3, N'A series of algorithms that mimic the human brain', 1),
    (3, N'A type of database', 0),
    (3, N'A programming language', 0),
    (3, N'A hardware component', 0),
    -- Question 4: Which Python library is used for data analysis?
    (4, N'Pandas', 1),
    (4, N'NumPy', 0),
    (4, N'Matplotlib', 0),
    (4, N'Scikit-learn', 0),
    -- Question 5: What is the correct syntax to print "Hello World" in Python?
    (5, N'print("Hello World")', 1),
    (5, N'echo("Hello World")', 0),
    (5, N'console.log("Hello World")', 0),
    (5, N'printf("Hello World")', 0),
    -- Question 6: Which keyword is used to define a function in Python?
    (6, N'def', 1),
    (6, N'function', 0),
    (6, N'fun', 0),
    (6, N'method', 0),
    -- Question 7: What is the output of the expression: 3 + 5 * 2 in Python?
    (7, N'13', 1),
    (7, N'16', 0),
    (7, N'11', 0),
    (7, N'10', 0),
    -- Question 8: How do you create a list in Python?
    (8, N'my_list = [1, 2, 3]', 1),
    (8, N'my_list = (1, 2, 3)', 0),
    (8, N'my_list = {1, 2, 3}', 0),
    (8, N'my_list = 1, 2, 3', 0),
    -- Question 9: What does the len() function do in Python?
    (9, N'Returns the length of an object', 1),
    (9, N'Returns the sum of elements', 0),
    (9, N'Returns the average value', 0),
    (9, N'Returns the type of object', 0),
    -- Question 10: Which of the following is a valid variable name in Python?
    (10, N'myVariable', 1),
    (10, N'123variable', 0),
    (10, N'my-variable', 0),
    (10, N'@myVariable', 0),
    -- Question 11: What is the output of the following code: x = 10; print(x + 5)?
    (11, N'15', 1),
    (11, N'10', 0),
    (11, N'5', 0),
    (11, N'50', 0),
    -- Question 12: How do you add an element to the end of a list in Python?
    (12, N'append()', 1),
    (12, N'add()', 0),
    (12, N'push()', 0),
    (12, N'insert()', 0),
    -- Question 13: What is the difference between a tuple and a list in Python?
    (13, N'A tuple is immutable, a list is mutable', 1),
    (13, N'A tuple is mutable, a list is immutable', 0),
    (13, N'Both are immutable', 0),
    (13, N'Both are mutable', 0),
    -- Question 14: What does the "in" operator do in Python?
    (14, N'Checks if a value exists in a sequence', 1),
    (14, N'Adds a value to a sequence', 0),
    (14, N'Removes a value from a sequence', 0),
    (14, N'Sorts a sequence', 0),
    -- Question 15: What is the correct syntax to print "Hello World" in Java?
    (15, N'System.out.println("Hello World");', 1),
    (15, N'print("Hello World");', 0),
    (15, N'console.log("Hello World");', 0),
    (15, N'echo("Hello World");', 0),
    -- Question 16: Which keyword is used to define a class in Java?
    (16, N'class', 1),
    (16, N'Class', 0),
    (16, N'object', 0),
    (16, N'type', 0),
    -- Question 17: What is the default value of an int variable in Java?
    (17, N'0', 1),
    (17, N'1', 0),
    (17, N'null', 0),
    (17, N'-1', 0),
    -- Question 18: How do you declare an array in Java?
    (18, N'int[] myArray = new int[5];', 1),
    (18, N'int myArray = [5];', 0),
    (18, N'int[] myArray = {5};', 0),
    (18, N'myArray = new int[5];', 0),
    -- Question 19: What is the purpose of the "public static void main" method in Java?
    (19, N'It is the entry point of a Java program', 1),
    (19, N'It defines a variable', 0),
    (19, N'It creates a class', 0),
    (19, N'It handles exceptions', 0),
    -- Question 20: Which of the following is a valid variable name in Java?
    (20, N'myVariable', 1),
    (20, N'123variable', 0),
    (20, N'my-variable', 0),
    (20, N'@myVariable', 0),
    -- Question 21: What is the output of the following code: int x = 5; System.out.println(x + 3)?
    (21, N'8', 1),
    (21, N'5', 0),
    (21, N'3', 0),
    (21, N'15', 0),
    -- Question 22: What does the "new" keyword do in Java?
    (22, N'Creates an object or allocates memory', 1),
    (22, N'Deletes an object', 0),
    (22, N'Initializes a variable', 0),
    (22, N'Calls a method', 0),
    -- Question 23: What is the difference between "==" and ".equals()" in Java?
    (23, N'"==" compares references, ".equals()" compares content', 1),
    (23, N'"==" compares content, ".equals()" compares references', 0),
    (23, N'Both compare references', 0),
    (23, N'Both compare content', 0),
    -- Question 24: What does the "for" loop do in Java?
    (24, N'Iterates over a range of values or a collection', 1),
    (24, N'Creates a new variable', 0),
    (24, N'Deletes a variable', 0),
    (24, N'Calls a function', 0),
    -- Question 25: What is the purpose of software architecture?
    (25, N'It provides a blueprint for a system', 1),
    (25, N'It compiles the code', 0),
    (25, N'It runs the application', 0),
    (25, N'It manages databases', 0),
    -- Question 26: What does IaaS stand for?
    (26, N'Infrastructure as a Service', 1),
    (26, N'Information as a Service', 0),
    (26, N'Internet as a Service', 0),
    (26, N'Integration as a Service', 0),
    -- Question 27: What is the main component of a Flutter app?
    (27, N'Widgets', 1),
    (27, N'Templates', 0),
    (27, N'Modules', 0),
    (27, N'Controllers', 0),
    -- Question 28: What is the first step in securing a network?
    (28, N'Identifying vulnerabilities', 1),
    (28, N'Installing software updates', 0),
    (28, N'Changing passwords', 0),
    (28, N'Encrypting data', 0),
    -- Question 29: What is a blockchain?
    (29, N'A decentralized ledger technology', 1),
    (29, N'A centralized database', 0),
    (29, N'A programming language', 0),
    (29, N'A type of server', 0);

-- 12. Bảng QuizQuestion
INSERT INTO QuizQuestion (quizID, questionID)
VALUES
    -- Quiz 1 (lessonID = 4, 2 câu hỏi)
    (1, 1),
    (1, 2),
    -- Quiz 2 (lessonID = 8, 1 câu hỏi)
    (2, 3),
    -- Quiz 3 (lessonID = 11, 1 câu hỏi)
    (3, 4),
    -- Quiz 4 (lessonID = 15, 20 câu hỏi)
    (4, 5),
    (4, 6),
    (4, 7),
    (4, 8),
    (4, 9),
    (4, 10),
    (4, 11),
    (4, 12),
    (4, 13),
    (4, 14),
    (4, 15),
    (4, 16),
    (4, 17),
    (4, 18),
    (4, 19),
    (4, 20),
    (4, 21),
    (4, 22),
    (4, 23),
    (4, 24),
    -- Quiz 5 (lessonID = 27, 1 câu hỏi)
    (5, 25),
    -- Quiz 6 (lessonID = 30, 1 câu hỏi)
    (6, 26),
    -- Quiz 7 (lessonID = 34, 1 câu hỏi)
    (7, 27),
    -- Quiz 8 (lessonID = 38, 1 câu hỏi)
    (8, 28),
    -- Quiz 9 (lessonID = 42, 1 câu hỏi)
    (9, 29);
    -- Quiz 10 (lessonID = 46, không có câu hỏi trong dữ liệu cung cấp)


-- 13. Bảng PricePackage
INSERT INTO PricePackage (courseID, name, accessDuration, listPrice, salePrice, description, status)
VALUES
    -- Full-Stack Web Development (courseID = 1)
    (1, N'Free', NULL, 0.00, 0.00, N'Free access to basic course materials without time limit.', 'Active'),
    (1, N'Basic', 1, 500.00, 400.00, N'Access to course materials for 1 month.', 'Active'),
    (1, N'Standard', 3, 1000.00, 800.00, N'Access to all course materials and quizzes for 3 months.', 'Active'),
    (1, N'Premium', 6, 1500.00, 1200.00, N'Full access with mentoring support for 6 months.', 'Active'),
    (1, N'Lifetime', NULL, 2500.00, 2000.00, N'Unlimited access to all course materials forever.', 'Active'),
    -- AI with TensorFlow & PyTorch (courseID = 2)
    (2, N'Free', NULL, 0.00, 0.00, N'Free access to introductory AI lessons without time limit.', 'Active'),
    (2, N'Basic', 1, 600.00, 500.00, N'Access to AI course materials for 1 month.', 'Active'),
    (2, N'Standard', 3, 1200.00, 1000.00, N'Access to AI course materials and projects for 3 months.', 'Active'),
    (2, N'Premium', 6, 1800.00, 1500.00, N'Full AI course access with expert support for 6 months.', 'Active'),
    (2, N'Lifetime', NULL, 3000.00, 2500.00, N'Unlimited access to all AI course materials forever.', 'Active'),
    -- Data Science with Python & Spark (courseID = 3)
    (3, N'Free', NULL, 0.00, 0.00, N'Free access to basic data science lessons without time limit.', 'Active'),
    (3, N'Basic', 1, 450.00, 350.00, N'Access to data science materials for 1 month.', 'Active'),
    (3, N'Standard', 3, 900.00, 700.00, N'Access to data science materials and quizzes for 3 months.', 'Active'),
    (3, N'Premium', 6, 1400.00, 1100.00, N'Full access with data science mentoring for 6 months.', 'Active'),
    (3, N'Lifetime', NULL, 2200.00, 1800.00, N'Unlimited access to all data science materials forever.', 'Active'),
    -- Mastering Python & Java (courseID = 4)
    (4, N'Free', NULL, 0.00, 0.00, N'Free access to basic programming lessons without time limit.', 'Active'),
    (4, N'Basic', 1, 400.00, 300.00, N'Access to Python and Java lessons for 1 month.', 'Active'),
    (4, N'Standard', 3, 800.00, 600.00, N'Access to Python and Java lessons for 3 months.', 'Active'),
    (4, N'Premium', 6, 1200.00, 900.00, N'Full access with programming support for 6 months.', 'Active'),
    (4, N'Lifetime', NULL, 2000.00, 1600.00, N'Unlimited access to all programming materials forever.', 'Active'),
    -- Software Architecture with Git (courseID = 5)
    (5, N'Free', NULL, 0.00, 0.00, N'Free access to software architecture basics without time limit.', 'Active'),
    (5, N'Basic', 1, 550.00, 450.00, N'Access to software architecture lessons for 1 month.', 'Active'),
    (5, N'Standard', 3, 1100.00, 900.00, N'Access to software architecture lessons for 3 months.', 'Active'),
    (5, N'Premium', 6, 1600.00, 1300.00, N'Full access with advanced mentoring for 6 months.', 'Active'),
    (5, N'Lifetime', NULL, 2700.00, 2200.00, N'Unlimited access to all architecture materials forever.', 'Active'),
    -- Cloud Computing Essentials (courseID = 6)
    (6, N'Basic', 3, 1000000, 800000, NULL, 'Active'),
    (6, N'Standard', 6, 1800000, 1500000, NULL, 'Active'),
    (6, N'Premium', 12, 3000000, 2500000, NULL, 'Active'),
    -- Mobile App Development with Flutter (courseID = 7)
    (7, N'Basic', 3, 1200000, 1000000, NULL, 'Active'),
    (7, N'Standard', 6, 2000000, 1700000, NULL, 'Active'),
    (7, N'Premium', 12, 3500000, 3000000, NULL, 'Active'),
    -- Cybersecurity Fundamentals (courseID = 8)
    (8, N'Basic', 3, 900000, 700000, NULL, 'Inactive'),
    (8, N'Standard', 6, 1600000, 1300000, NULL, 'Inactive'),
    (8, N'Premium', 12, 2800000, 2400000, NULL, 'Inactive'),
    -- Blockchain Technology Basics (courseID = 9)
    (9, N'Basic', 3, 1100000, 900000, NULL, 'Inactive'),
    (9, N'Standard', 6, 1900000, 1600000, NULL, 'Inactive'),
    (9, N'Premium', 12, 3200000, 2800000, NULL, 'Inactive'),
    -- Advanced Data Visualization (courseID = 10)
    (10, N'Basic', 3, 1000000, 800000, NULL, 'Inactive'),
    (10, N'Standard', 6, 1800000, 1500000, NULL, 'Inactive'),
    (10, N'Premium', 12, 3000000, 2600000, NULL, 'Inactive');

-- 14. Bảng Registration
SET IDENTITY_INSERT Registration ON;
INSERT INTO Registration (registrationID, userID, lastUpdateBy, courseID, pricePackageID, totalCost, status, registrationTime, validFrom, validTo)
VALUES
    (1, 1, 23, 1, 3, 800.00, 'Paid', '2025-05-01', '2025-05-01', '2025-08-01'), -- Nguyễn Văn An, Full-Stack, Standard
    (2, 2, 24, 2, 9, 1500.00, 'Paid', '2025-05-02', '2025-05-02', '2025-11-02'), -- Trần Thị Bích, AI, Premium
    (3, 3, 23, 3, 12, 350.00, 'Submitted', '2025-05-03', '2025-05-03', '2025-06-03'), -- Lê Minh Châu, Data Science, Basic
    (4, 4, 24, 4, 18, 600.00, 'Paid', '2025-05-04', '2025-05-04', '2025-08-04'), -- Phạm Thị Duyên, Python & Java, Standard
    (5, 5, 23, 5, 25, 2200.00, 'Cancelled', '2025-05-05', NULL, NULL), -- Hoàng Văn Đạt, Software Arch, Lifetime
    (6, 5, 23, 5, 25, 2200.00, 'Paid', '2025-05-06', '2025-05-06', NULL), -- Hoàng Văn Đạt, Software Arch, Lifetime
    (7, 5, 23, 3, 12, 350.00, 'Submitted', '2025-05-09', '2025-05-09', '2025-06-09'), -- Hoàng Văn Đạt, Data Science, Basic
    (8, 5, 23, 3, 11, 0.00, 'Submitted', '2025-05-09', '2025-05-09', NULL), -- Hoàng Văn Đạt, Data Science, Free
    (9, 1, 23, 6, 26, 800000.00, 'Submitted', '2025-05-11', '2025-05-11', '2025-08-11'), -- Nguyễn Văn An, Cloud, Basic
    (10, 2, 23, 6, 27, 1500000.00, 'Paid', '2025-05-12', '2025-05-12', '2025-11-12'), -- Trần Thị Bích, Cloud, Standard
    (11, 3, 23, 7, 29, 1000000.00, 'Submitted', '2025-05-13', '2025-05-13', '2025-08-13'), -- Lê Minh Châu, Flutter, Basic
    (12, 4, 23, 7, 31, 3000000.00, 'Paid', '2025-05-14', '2025-05-14', '2026-05-14'), -- Phạm Thị Duyên, Flutter, Premium
    (13, 5, 23, 4, 19, 900.00, 'Paid', '2025-05-16', '2025-05-16', '2025-11-16'), -- Hoàng Văn Đạt, Python & Java, Premium
    (14, 6, 23, 8, 33, 1300000.00, 'Submitted', '2025-05-17', '2025-05-17', '2025-11-17'), -- Vũ Thị Hà, Cybersecurity, Standard
    (15, 7, 23, 9, 36, 900000.00, 'Submitted', '2025-05-20', '2025-05-20', '2025-08-20'), -- Đặng Văn Hùng, Blockchain, Basic
    (16, 8, 23, 9, 38, 2800000.00, 'Paid', '2025-05-21', '2025-05-21', '2026-05-21'), -- Bùi Thị Lan, Blockchain, Premium
    (17, 9, 23, 10, 39, 800000.00, 'Submitted', '2025-05-22', '2025-05-22', '2025-08-22'), -- Ngô Văn Minh, Data Viz, Basic
    (18, 10, 23, 10, 40, 1500000.00, 'Submitted', '2025-05-23', '2025-05-23', '2025-11-23'); -- Lý Thị Ngọc, Data Viz, Standard
SET IDENTITY_INSERT Registration OFF;


-- 15. Bảng Slider
INSERT INTO Slider (title, image, backlink, status, notes, userID)
VALUES
    (N'Developer Working on Web Interface', N'image1.jpg', N'https://www.sanomalearning.com/en/who-we-are/our-learning-companies/itslearning/', 'Active', N'Illustrates a developer working on a web UI – suitable for web development topics.', 21),
    (N'HTML/CSS Code Displayed on Monitor', N'image2.jpg', N'https://www.inspyrsolutions.com/continuous-learning-as-an-it-professional/', 'Active', N'Shows HTML/CSS code on screen – ideal for frontend design and UI coding themes.', 22),
    (N'AI Symbol with Digital Brain', N'image3.jpg', N'https://eclass.edu.vn/en/news/details/169/it-is-quite-easy-to-use-basic-ways-to-inspire-oneself-to-learn-english', 'Inactive', N'Digital brain symbolizing artificial intelligence – fits AI, machine learning, and tech innovation topics.', 21),
    (N'Data Analytics with Charts and Graphs', N'image4.jpg', N'https://career-advice.jobs.ac.uk/career-development/what-is-continuing-professional-development-cpd/', 'Active', N'Depicts business data analysis – relevant for business intelligence and analytics dashboards.', 22),
    (N'Dashboard Displaying Data Visualizations', N'image5.jpg', N'https://baskervilledrummond.com/ways-training-can-help-lead-to-a-successful-rollout-of-an-it-system/', 'Active', N'Dashboard showing data visualizations – great for monitoring tools or admin interfaces.', 21),
    (N'Python Code Displayed on Screen', N'image6.jpg', N'https://www.turnitin.com/blog/understanding-educational-technology-and-its-impact-on-the-learning-landscape', 'Inactive', N'Screen with Python code – useful for programming tutorials, online courses, or educational content.', 22),
    (N'Project Management Interface on Screen', N'image7.jpg', N'https://www.polyu.edu.hk/its/it-services/online-training-resources/', 'Active', N'Project tracking interface – represents Scrum, Agile, or project planning tools.', 21),
    (N'Software Engineer Reviewing Code', N'image8.jpg', N'https://elearningindustry.com/online-it-training-applications', 'Active', N'Software engineer reviewing code – symbolizes quality assurance, debugging, or code review process.', 22),
    (N'Developer Writing JavaScript Code', N'image9.jpg', N'https://www.tua.edu.ph/blogs/what-is-a-bs-it-course/', 'Active', N'Developer writing JavaScript – suitable for frontend frameworks or scripting topics.', 21);

-- 16. Bảng Setting
INSERT INTO Setting (type, value, orderNum, status, userID)
VALUES
    ('Security', '5', 1, 'Active',27),
    ('Session', '30', 2, 'Active',28),
    ('Language', 'en', 3, 'Active',27),
    ('Currency', 'USD', 4, 'Active',28),
    ('Maintenance', 'False', 5, 'Active',27);

-- Bảng UserLessonProcess
INSERT INTO UserLessonProgress (userID, lessonID, status, completedAt, watchProgress, score, createDate, updateDate) 
VALUES 
(5, 13, 'Completed', '2025-05-20 10:00:00', 100.00, NULL, '2025-05-15 09:00:00', '2025-05-20 10:00:00'), 
(5, 14, 'InProgress', NULL, 80.00, NULL, '2025-05-20 10:00:00', '2025-06-07 10:00:00'), 
(1, 2, 'Completed', '2025-05-05 12:00:00', 100.00, NULL, '2025-05-01 00:00:00', '2025-05-05 12:00:00'), 
(1, 3, 'Completed', '2025-05-10 14:00:00', 100.00, NULL, '2025-05-05 00:00:00', '2025-05-10 14:00:00'), 
(1, 4, 'Completed', '2025-05-15 15:00:00', NULL, 85.00, '2025-05-10 00:00:00', '2025-05-15 15:00:00'), 
(2, 7, 'Completed', '2025-05-10 00:00:00', 100.00, NULL, '2025-05-02 00:00:00', '2025-05-10 00:00:00'), 
(2, 8, 'Completed', '2025-05-15 00:00:00', NULL, 90.00, '2025-05-10 00:00:00', '2025-05-15 00:00:00'), 
(3, 32, 'InProgress', NULL, 50.00, NULL, '2025-05-13 00:00:00', '2025-06-07 10:00:00'), 
(3, 33, 'NotStarted', NULL, 0.00, NULL, '2025-05-13 00:00:00', NULL), 
(4, 32, 'Completed', '2025-05-14 00:00:00', 100.00, NULL, '2025-05-14 00:00:00', '2025-05-14 00:00:00'), 
(4, 33, 'Completed', '2025-05-15 00:00:00', 100.00, NULL, '2025-05-14 00:00:00', '2025-05-15 00:00:00'), 
(4, 34, 'Completed', '2025-05-16 00:00:00', NULL, 88.00, '2025-05-15 00:00:00', '2025-05-16 00:00:00'), 
(6, 36, 'InProgress', NULL, 30.00, NULL, '2025-05-17 00:00:00', '2025-06-07 10:00:00'), 
(7, 40, 'InProgress', NULL, 60.00, NULL, '2025-05-20 00:00:00', '2025-06-07 10:00:00'), 
(9, 44, 'InProgress', NULL, 40.00, NULL, '2025-05-22 00:00:00', '2025-06-07 10:00:00');

-- Bảng UserLessonNotes
INSERT INTO UserLessonNotes (userID, lessonID, content, createDate, updateDate)
VALUES
    (5, 13, N'Ghi chú: Danh sách trong Python rất hữu ích để lưu trữ dữ liệu tuần tự. Cần chú ý đến phương thức append() và pop() để thao tác với danh sách.', '2025-05-15 09:00:00', '2025-05-20 10:00:00'),
    (1, 2, N'Ghi chú: JSX trong React giúp viết HTML trong JavaScript, rất trực quan. Cần hiểu rõ về state và Props.', '2025-05-05 12:00:00', '2025-05-05 12:00:00'),
    (2, 7, N'Ghi chú: Cấu trúc mạng nơ-ron gồm nhiều tầng, cần tìm hiểu thêm về hàm kích hoạt như ReLU.', '2025-05-10 00:00:00', '2025-05-10 00:00:00'),
    (4, 32, N'Ghi chú: Widget trong Flutter rất mạnh mẽ, cần nắm rõ StatelessWidget và StatefulWidget.', '2025-05-14 00:00:00', '2025-05-14 00:00:00'),
    (7, 40, N'Ghi chú: Blockchain là công nghệ phân tán, cần tìm hiểu thêm về cơ chế đồng thuận như Proof of Work.', '2025-05-20 00:00:00', '2025-05-20 00:00:00'),
    (9, 44, N'Ghi chú: Trực quan hóa dữ liệu nâng cao cần chú ý đến việc chọn màu sắc và biểu đồ phù hợp.', '2025-05-22 00:00:00', '2025-06-07 10:00:00');

-- INSERT Image
INSERT INTO Image (imageName, thumbnail, courseID)
SELECT img.imageName, img.thumbnail, c.courseID
FROM (VALUES
    (N'Full-Stack Web Development - 1', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBcF0VcysLI9gzQu9g3UjiSJguiGcnTMLxMQ&s', N'Full-Stack Web Development'),
    (N'AI with TensorFlow & PyTorch - 1', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHozmSJn0IXb7sclV02QF_DkRXS6xefkZK3g&s', N'AI with TensorFlow & PyTorch'),
    (N'Data Science with Python & Spark - 1', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuKw-kSvTVbGM5VWCNdjiNczV5jIv0Nku-fw&s', N'Data Science with Python & Spark'),
    (N'Mastering Python & Java - 1', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHNkQKu7DdioZnI0mBT2aw_yvujdxkHhoo4w&s', N'Mastering Python & Java'),
    (N'Software Architecture with Git - 1', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCZb4ZLR-EsjoXTPr2KD74t0UDiRZ5ZTuitA&s', N'Software Architecture with Git'),
    (N'Cloud Computing Essentials - 1', N'https://th.bing.com/th/id/OIP.fUjMIljIXFm7Q5gOyE_EwQHaFL?w=249&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', N'Cloud Computing Essentials'),
    (N'Mobile App Development with Flutter - 1', N'https://th.bing.com/th/id/OIP.AbkkytIRIUhSlg1oLslz8QHaDt?w=286&h=174&c=7&r=0&o=5&dpr=1.3&pid=1.7', N'Mobile App Development with Flutter'),
    (N'Cybersecurity Fundamentals - 1', N'https://th.bing.com/th/id/OIP.22CCDeOPCYmNZUHAORU91QAAAA?w=311&h=175&c=7&r=0&o=5&dpr=1.3&pid=1.7', N'Cybersecurity Fundamentals'),
    (N'Blockchain Technology Basics - 1', N'https://th.bing.com/th/id/OIP.bbXUL1BC_-345pO5ZIy0vQHaEK?w=300&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', N'Blockchain Technology Basics'),
    (N'Advanced Data Visualization - 1', N'https://th.bing.com/th/id/OIP.WxrQtdTcOXAxbFRqUTw51wHaEK?w=312&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', N'Advanced Data Visualization')
) AS img(imageName, thumbnail, courseName)
JOIN Course c ON c.courseName = img.courseName
WHERE NOT EXISTS (
    SELECT 1 FROM Image i WHERE i.imageName = img.imageName
);