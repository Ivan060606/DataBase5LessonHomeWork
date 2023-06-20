USE 4lessdbhw;
-- 1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), 
-- которые не старше 20 лет.
CREATE VIEW first_task AS
SELECT users.firstname, users.lastname, profiles.hometown, profiles.gender
FROM users 	INNER JOIN profiles
ON users.id = profiles.user_id
WHERE birthday > '2003-06-16';
SELECT * FROM first_task;

-- 2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователей, 
-- указав имя и фамилию пользователя, количество отправленных сообщений и место в рейтинге (первое место у 
-- пользователя с максимальным количеством сообщений) . (используйте DENSE_RANK)

CREATE VIEW second_task AS
SELECT COUNT(from_user_id), from_user_id, 
DENSE_RANK()
OVER(/*PARTITION BY COUNT(from_user_id)*/ ORDER BY COUNT(from_user_id) DESC) AS 'Place'
FROM messages
group by from_user_id;
SELECT * FROM second_task;

-- 3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) и найдите разницу 
-- дат отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)


CREATE VIEW third_task AS
SELECT id, from_user_id, to_user_id, body, created_at, ((created_at-LAG(created_at) OVER())/100) AS 'different' FROM messages;
SELECT * FROM third_task;

