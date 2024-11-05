-- Khóa ngoại từ bảng building tới bảng host
ALTER TABLE building
ADD CONSTRAINT PK_building_host
FOREIGN KEY (host_id) REFERENCES `host`(id);

-- Khóa ngoại từ bảng building tới bảng contractor
ALTER TABLE building
ADD CONSTRAINT PK_building_contractor
FOREIGN KEY (contractor_id) REFERENCES `contractor`(id);

-- Khóa ngoại từ bảng design tới bảng building
ALTER TABLE design
ADD CONSTRAINT fk_design_building
FOREIGN KEY (building_id) REFERENCES building(id);


-- Khóa ngoại từ bảng design tới bảng architect
ALTER TABLE design
ADD CONSTRAINT fk_design_architect
FOREIGN KEY (architect_id) REFERENCES architect(id);

-- Khóa ngoại từ bảng work tới bảng building
ALTER TABLE work
ADD CONSTRAINT fk_work_building
FOREIGN KEY (building_id) REFERENCES building(id);

-- Khóa ngoại từ bảng work tới bảng worker
ALTER TABLE work
ADD CONSTRAINT fk_work_worker
FOREIGN KEY (worker_id) REFERENCES worker(id);
