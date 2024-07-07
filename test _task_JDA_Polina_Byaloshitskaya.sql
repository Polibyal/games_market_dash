-- Задача №1. Напишите SQL-запрос
-- Имеется таблица city_population с населением городов: city (наименование города), population (численность населения).
-- Необходимо написать запрос, который выводит город с минимальным населением.


SELECT city
FROM city_population
ORDER BY population
LIMIT 1;

-- Задача №2. Напишите SQL-запрос
-- Напишите SQL-запрос, который считает, сколько уникальных имен (Name) имеется по каждому ID для Label, содержащих “bot” в названии (независимо от регистра букв).

--CREATE TABLE A(
--  ID INTEGER,
--  Name TEXT,
--  LABEL TEXT
--);
--
--INSERT INTO A(ID, NAME, LABEL) VALUES
--	(1, 'A', 'bot_vk'),
--    (1, 'B', 'bot_tg'),
--    (2, 'B', 'website'),
--    (2, 'C', 'bot_vk'),
--    (3, 'A', 'website'),
--    (3, 'C', 'website'),
--    (4, 'B', 'bot_tg'),
--    (4, 'A', 'Bot_tg'),
--    (5, 'C', 'Bot_vk'),
--    (5, 'A', 'website'),
--    (5, 'A', 'botvk');

SELECT ID, COUNT(DISTINCT Name)
FROM A
WHERE Label ILIKE '%bot%'
GROUP BY ID;

-- Задача №3. Напишите SQL-запрос
-- Есть таблица пользователей user (user_id — id пользователя, installed_at — дата установки приложения) и таблица платежей payment (user_id, payment_at — дата оплаты, amount — сумма платежа). Необходимо написать SQL-запрос, который считает накопительный ARPU с группировкой по месяцу оплаты. Считать только оплаты пользователей, установивших приложение в январе 2023 года.

SELECT year_month,
        SUM(ARPU) OVER (ORDER BY year_month)
FROM (
    SELECT TO_CHAR(payment_at, 'yyyy-MM') AS year_month,
            SUM(amount)/COUNT(DISTINCT payment.user_id) AS ARPU
    FROM user
    INNER JOIN payment ON user.user_id = payment.user_id
    WHERE installed_at >= '2023-01-01' AND installed_at < '2023-02-01'
    GROUP BY TO_CHAR(payment_at, 'yyyy-MM')
    ) ARPUs

