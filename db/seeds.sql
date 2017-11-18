
DROP DATABASE IF EXISTS botflow;
CREATE DATABASE botflow;

USE botflow;


DROP TABLE IF EXISTS taskComments;
DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS sprints;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS teams;



CREATE TABLE teams (
  id SERIAL,
  name VARCHAR(200) NOT NULL,
  created_by INT,
  PRIMARY KEY (id),
  UNIQUE (name)
);

CREATE TABLE users (
  id INT NOT NULL,
  username VARCHAR(20) NOT NULL,
  password VARCHAR(25) NULL DEFAULT '',
  team_id INT NOT NULL,
  is_product_owner NUMERIC(1) DEFAULT 0,
  is_scrum_master NUMERIC(1) DEFAULT 0,
  creation_dt TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (id),
  UNIQUE (team_id, username),
  FOREIGN KEY (team_id) REFERENCES teams (id)
);


CREATE TABLE messages (
  id SERIAL,
  message TEXT,
  sender_id INT,
  receiver_id INT,
  created_dt TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE sprints (
  id SERIAL,
  name VARCHAR(200) NOT NULL,
  team_id INT,
  url text,
  status NUMERIC(1), -- 0 not started, 1 current, 2 backlog, 3 archived
  total_estimated_units INT,
  completed_units INT,
  start_date TIMESTAMP,
  end_date TIMESTAMP, -- start_date + 2 weeks
  PRIMARY KEY (id),
  UNIQUE (team_id, name),
  FOREIGN KEY (team_id) REFERENCES teams (id)
);

CREATE TABLE tasks (
  id SERIAL,
  url text,
  name VARCHAR(200) NOT NULL,
  sprint_id INT,
  assignee_id INT,
  creator_id INT,
  status NUMERIC(1), -- 0 not started, 1 in progress, 2 in qa, 3 merged
  pull_request_id VARCHAR(40), --GitHub commit eg. 2be72856ac7ebeedd53d816cac153a4d79d02f6a
  estimated_units INT,
  priority CHAR(7) DEFAULT 'medium',
  start_date TIMESTAMP,
  end_date TIMESTAMP, -- start_date + 2 weeks
  creation_dt TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (id),
  FOREIGN KEY (assignee_id) REFERENCES users (id),
  FOREIGN KEY (creator_id) REFERENCES users (id),
  FOREIGN KEY (sprint_id) REFERENCES sprints (id)
);

CREATE TABLE taskComments (
  id SERIAL,
  comment TEXT,
  user_id INT,
  task_id INT,
  PRIMARY KEY (id),
  FOREIGN KEY (task_id) REFERENCES tasks (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
);
--
--
INSERT INTO teams (name)
VALUES ('HackAssembly'), ('Botsters');

INSERT INTO users (id, username, team_id, is_product_owner, is_scrum_master)
VALUES
(1, 'ibrahim', 1, 0, 0),
(2, 'yuheng', 1, 0, 0),
(3, 'clarence', 1, 0, 0),
(4, 'jason', 2, 1, 0),
(5, 'fred', 2, 0, 0);
--
--
INSERT INTO sprints (name, team_id, status, start_date, end_date)
VALUES
('backlog', 1, 0, NULL, NULL),
('environment setup', 1, 1, NOW()::date, NOW()::date + INTERVAL '2 WEEKS'),
('backlog', 2, 0, NOW()::date, NOW()::date + INTERVAL '2 WEEKS')
;



INSERT INTO tasks(name, sprint_id, assignee_id, creator_id, status, pull_request_id,
  estimated_units, priority, start_date, end_date)
VALUES ('Create db schema', 1, 1, 1, 0, NULL, 4, 'high', NULL, NULL);
