create type user_role as enum(
'company',
'talent',
'mentor',
'admin'
);
create type user_status as enum(
'active',
'inactive',
'banned'
);
--người dùng
create table user1(
userId varchar(255) primary key,
username varchar(255) unique,
email varchar(255) unique,
password varchar(255),
gender varchar(255), 
cache varchar(255),
dateOfBirth date,
phoneNumber int unique,
address varchar(255),
userRole user_role,
status user_status,
updatedDate date,
isDeleted bit
);
--Doanh nghiệpnghiệp
create type company_status as enum(
'pending',
'active',
'rejected'
);
create table company(
companyId varchar(255) primary key,
userId varchar(255) not null unique references user1(userId),
companyName varchar(255) not null unique,
address varchar(255),
email varchar(255) unique,
phoneNumber int unique,
status company_status not null,
industry varchar(255),
description text,
website varchar(255),
scale varchar(255),
createdDate date,
updatedDate date
);
--Ứng viên
create table talent(
talentId varchar(255) primary key,
userId varchar(255) not null unique references user1(userId),
profile_url text,
portfolio text, --hồ sơ năng lực
joinedDate date
);
--chuyên môn
create table expertise 
(
expertiseId varchar(255) primary key,
expertiseName varchar(255),
createdDate date,
createdBy varchar(255),
updatedDate date,
updatedBy varchar(255),
isDeleted bit,
note text
);
--cố vấn viên
create table mentor(
mentorId varchar(255) primary key,
userId varchar(255) not null unique references user1(userId),
expertiseId varchar(255) not null references expertise(expertiseId),
portfolio text,
profile_url text,
joinedDate date
);
--quản trị viên lab
create table labAdministrator(
labAdminId varchar(255) primary key,
userId varchar(255) not null unique references user1(userId),
department varchar(255), --bộ phận
joinedDate date,
updatedDate date,
updatedBy varchar(255)
);
--Giai đoạn ý tưởng
create table stageIdea(
stageIdeaId varchar(255) primary key,
numberReviewer int,
startDate date,
endDate date,
result varchar(255),
stageNumber int,
createdDate date,
createdBy varchar(255),
updatedDate date,
updatedBy varchar(255),
isDeleted bit,
note text
);
create type project_status as enum(
'pending',--chờ xử lí
'approved',--được thông qua
'inProgress',--dang thực hiện
'completed',--đã hoàn thành
'cancelled'--đã hủy
);
create table project(
projectId varchar(255) primary key,
companyId varchar(255) not null unique references company(companyId),
mentorId varchar(255) not null unique references mentor(mentorId),
createdDate date,
createdBy varchar(255),
topic varchar(255) not null,
description text,
status project_status not null,
teamSize int, 
updatedDate date,
updatedBy varchar(255),
isDeleted bit
);
--Tiêu chí
create table criteria
(
criteriaId varchar(255) primary key,
question varchar(255),
createdDate date,
createdBy varchar(255),
updatedDate date,
updatedBy varchar(255),
isDeleted bit,
note text
);
--Mẫu tiêu chí
create table criteriaForm(
criteriaformId varchar(255) primary key,
title varchar(255),
createdDate date,
createdBy varchar(255),
updatedDate date,
updatedBy varchar(255),
isDeleted bit,
note text
);
--kết hợp
create table criteria_x_criteriaForm(
criteria_x_criteriaFormId varchar(255) primary key,
criteriaId varchar(255) references criteria(criteraId),
criteriaformId varchar(255) references criteriaForm(criteriaFormId),
createdDate date,
createdBy varchar(255),
updatedDate date,
updatedBy varchar(255),
isDeleted bit,
note text
);
--Nhiệm vụ
create table task(
taskId varchar(255) primary key,
projectId varchar(255) not null references project(projectId),
assignedTo varchar(255) references talent(talentId),
title varchar(255),
description text,
createdDate date,
createdBy varchar(255),
updatedDate date,
updatedBy varchar(255),
isDeleted bit,
note text
);
--Thành viên nhóm
create table teamMember(
teamMemberId varchar(255) primary key,
userId varchar(255) not null references user1(userId),
projectId varchar(255) references project(projectId),
role varchar(255),
status varchar(255),
mentorConclusion text,
joinDate date,
leaveDate date,
updatedDate date,
updatedBY varchar(255),
isDeleted bit
);
create type job_status as enum(
'open',
'closed'
);
create type job_type as enum(
'fulltime',
'parttime',
'internship',
'freelance'
);
create table job(
jobId varchar(255) primary key,
companyId varchar(255) not null references company(companyId),
Title varchar(255),
description text,
requirement text,
salary varchar(255),
status job_status,
type job_type,
createdDate date,
updatedDate date
);
create type application_status as enum(
'submitted',
'reviewing',
'accepted',
'rejected'
);
create table jobApplication(
ApplicationId varchar(255) primary key,
jobId varchar(255) not null references job(jobId),
talentId varchar(255) not null references talent(talentId),
applyDate date,
status application_status
);
--Đánh giá
create table review(
reviewId varchar(255) primary key,
projectId varchar(255) references project(projectId),
number int,
reviewDate date,
description text,
fileUpload varchar(255),
createdDate date,
createdBy varchar(255),
updatedDate date,
updatedBy varchar(255),
isDeleted bit,
note text
);
create type report_type as enum(
'monthly',
'phase'
);
--Báo cáo
create table report(
reportId varchar(255) primary key,
projectId varchar(255) not null references project(projectId),
mentorId varchar(255) not null references mentor(mentorId),
file_url text,
type report_type not null,
createdDate date
);
create table mentorFeedback(
mentorFeedbackId varchar(255) primary key,
projectId varchar(255) not null unique references project(projectId),
thesisContent varchar(255),--nội dung luận điểm
thesisForm varchar(255),--mẫu luận điểm
achievementLevel varchar(255),
limitation varchar(255),
createdDate date,
createdBy varchar(255),
updatedDate date,
updatedBy varchar(255),
isDeleted bit,
note text
);
create table conservation(
conservationId varchar(255) primary key
);
create table memberConservation(
memberConservation varchar(255) primary key,
userId varchar(255) not null unique references user1(userId),
conservationId varchar(255) not null unique references conservation(conservationId)
);
create table message(
messageId varchar(255) primary key,
conservationId varchar(255) not null unique references conservation(conservationId),
sendById varchar(255) not null unique references user1(userId),
content text,
createdDate date
);
create table systemAdmin(
systemAdminId varchar(255) primary key,
userId varchar(255) not null unique references user1(userId),
department varchar(255), --bộ phận
joinedDate date,
updatedDate date,
updatedBy varchar(255),
note text
);
create table fund(
fundId varchar(255) primary key,
projectId varchar(255) not null references project(projectId),
companyId varchar(255) not null references company(companyId),
amount numeric(20,3) not null,
team_share float,
mentor_share float,
lab_share float,
createdDate date,
updatedDate date
);
create table fundTransaction(
fundTransactionId varchar(255),
fundId varchar(255) not null references fund(fundId),
userId varchar(255) references user1(userId),
amount numeric(20,3) not null,
description text,
createdDate date
);
create type contract_status as enum(
'active',
'expired',
'terminated'
);
create table partnershipContract(
contractId varchar(255) primary key,
companyId varchar(255) not null references company(companyId),
projectId varchar(255) not null references project(projectId),
contracTitle varchar(255) not null,
startDate date,
endDate date,
status contract_status not null,
description text
);
create table notification(
notificationId varchar(255) primary key,
userId varchar(255) references user1(userId),
projectId varchar(255) references project(projectId),
title varchar(255) not null,
description text,
isRead bit,
createdDate date,
createdBy varchar(255),
updatedDate date,
updatedBy varchar(255),
isDeleted bit,
note text
);
