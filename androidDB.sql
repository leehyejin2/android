use myandroid;

DELETE FROM m_allergy WHERE phone = '010-7226-3195';
UPDATE member SET phone = '01072263195' WHERE phone = '010-7226-3195';
UPDATE member_image SET i_time = '2025-06-11' WHERE i_id = 'i1z';
DELETE FROM member_image WHERE i_id = 'i25';
DELETE FROM analyzed_food WHERE af_id = '1';
DELETE FROM analyzed_detail WHERE af_id = '1';
DELETE FROM protector_notification WHERE pn_id = 'pn4';
DELETE FROM medicine WHERE m_id = 'm1';
DELETE FROM analyzed_medicine WHERE m_id = 'm1';
DELETE FROM analyzed_medicine WHERE i_id = 'i25';
DELETE FROM protector_notification WHERE i_id = 'i25';

select * from member;
select * from member_image;
select * from medicine;
select * from allergy;
select * from m_allergy;
select * from protector;
select * from analyzed_food;
select * from analyzed_detail;
select * from member_protector;
select * from protector_notification;
select * from analyzed_medicine;

-- insert member values("01072263195", "1", "이혜진","여");
-- insert m_allergy values("01072263195", "a8");
-- insert allergy values("a25", "식품 알레르기", "쇠고기");
-- UPDATE member_image SET image_url ="C:\\Users\\SAMSUNG\\OneDrive\\바탕 화면\\이미지 사진\\Ruzipen.jpg" WHERE i_id = "i1";

INSERT INTO protector_notification 
(pn_id, phone, p_id, i_id, message, n_time, is_read)
VALUES 
('pn3', '1', '1', 'i16', '음식이 촬영되었습니다.', '2025-11-24 14:30:00', 0);

create table member
(
	phone varchar(20) primary key,
	pw varchar(15),
    name varchar(20),
    gender varchar(20)
);
create table allergy
(
	a_id varchar(15) primary key,
	a_name varchar(50),
    arouse varchar(40)
);
create table m_allergy
(
	phone varchar(20),
	a_id varchar(15),
    primary key (phone, a_id)
);
create table protector
(
	p_id varchar(15) primary key,
	p_pw varchar(15),
    p_name varchar(20),
    p_phone varchar(20)
);
create table member_protector
(
	mp_id varchar(15) primary key,
	p_id varchar(15),
    phone varchar(20)
);
create table member_image
(
	i_id varchar(15) primary key,
	phone varchar(20),
    image_url varchar(255),
    i_time timestamp,
    image_type varchar(15)
);
create table analyzed_food
(
	af_id int auto_increment primary key,
	af_name varchar(40),
    accuracy FLOAT,
    food_intake int,
    i_id varchar(15),
    gpt_descrㅅiption varchar(255)
);
create table analyzed_detail
(
	af_id int,
	af_result varchar(40),
    allergy_risk int,
    ai_check varchar(10),
    PRIMARY KEY (af_id, af_result)
);
create table food_allergy
(
	af_id varchar(15),
	a_id varchar(15),
    primary key (af_id, a_id)
);
create table shared_data
(
	share_id varchar(15) primary key,
	mp_id varchar(15),
    i_id varchar(15)
);

create table medicine
(
	m_id varchar(15) primary key,
	m_name varchar(50),
    m_image varchar(50),
    ingredient varchar(50),
    effect TEXT,
    take TEXT,
    beware TEXT
);
create table analyzed_medicine
(
	am_id varchar(15) primary key,
	m_id varchar(15),
    i_id varchar(15)
);
create table medicine_allergy
(
	am_id varchar(15),
	a_id varchar(15),
    primary key (am_id, a_id)
);
create table protector_notification (
    pn_id VARCHAR(10) PRIMARY KEY, 
    phone VARCHAR(20),                     -- 사용자 전화번호 (누가 사진 찍었는지)
    p_id VARCHAR(15),                      -- 보호자 ID (알림 받는 대상)
    i_id VARCHAR(15),                      -- member_image 테이블의 이미지 ID
    message VARCHAR(255),                  -- 알림 내용
    n_time timestamp, 
    is_read int                            -- 읽음 여부 (0: 안읽음 / 1: 읽음)
);

alter table medicine_allergy add constraint fk_medicine_allergy_am_id foreign key (am_id) references analyzed_medicine (am_id); -- analyzed_medicine 테이블의 am_id 참조
alter table medicine_allergy add constraint fk_medicine_allergy_a_id foreign key (a_id) references allergy (a_id);
alter table member_image add constraint fk_member_image_phone foreign key (phone) references member (phone);
alter table analyzed_food add constraint fk_analyzed_food_i_id foreign key (i_id) references member_image (i_id);
alter table analyzed_detail add constraint fk_analyzed_detail_af_id foreign key (af_id) references analyzed_food (af_id);
alter table food_allergy add constraint fk_food_allergy_af_id foreign key (af_id) references analyzed_food (af_id);
alter table food_allergy add constraint fk_food_allergy_a_id foreign key (a_id) references allergy (a_id);
alter table analyzed_medicine add constraint fk_analyzed_medicine_m_id foreign key (m_id) references medicine (m_id);
alter table analyzed_medicine add constraint fk_analyzed_medicine_i_id foreign key (i_id) references member_image (i_id);
alter table shared_data add constraint fk_shared_data_mp_id foreign key (mp_id) references member_protector (mp_id);
alter table shared_data add constraint fk_shared_data_i_id foreign key (i_id) references member_image (i_id);
alter table member_protector add constraint fk_member_protector_p_id foreign key (p_id) references protector (p_id);
alter table member_protector add constraint fk_member_protector_phone foreign key (phone) references member (phone);
alter table m_allergy add constraint fk_m_allergy_phone foreign key (phone) references member (phone);
alter table m_allergy add constraint fk_m_allergy_a_id foreign key (a_id) references allergy (a_id);

alter table protector_notification add constraint fk_protector_notification_phone foreign key (phone) references member(phone);
ALTER TABLE protector_notification ADD CONSTRAINT fk_protector_notification_p_id FOREIGN KEY (p_id) REFERENCES protector(p_id);
ALTER TABLE protector_notification ADD CONSTRAINT fk_protector_notification_i_id FOREIGN KEY (i_id) REFERENCES member_image(i_id);