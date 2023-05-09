# SQL

![img.png](src/photos/img.png)

## Базы данных

**• Предназначены для долговременного хранения информации.** <br/>
**• Позволяют быстро находить нужные данные, так как обладают встроенными средствами поиска.** <br/>
**• Реляционные базы используют табличную структуру для хранения данных, а для работы с ними используют язык SQL.**

## СУБД

*СУБД - это всего лишь приложение, способное манипулировать данными.*

![img_1.png](src/photos/img_1.png)

**• Система управления базами данных. Например: MySQL, PostgreSQL, Oracle, MsSQL.** <br/>
**• «Надстройка» над базами данных, организующая работу с БД и добавляющая дополнительную функциональность.** <br/>
**• Каждая СУБД обладает своими отличиями. Например, встроенными типами данных.** <br/>
**• Каждая СУБД снабжена своим процедурным языком программирования.**

## DDL & DML

![img_2.png](src/photos/img_2.png)

## Создание таблиц

*Пример создания базы данных, схемы и таблицы:*

```postgresql
CREATE DATABASE company_repository;

CREATE SCHEMA company_storage;

CREATE TABLE company
(
    id   INT,
    name VARCHAR(128),
    date DATE
);
```

## Операция INSERT

*Операция INSERT позволяет производить вставку данных в таблицу.*

```postgresql
CREATE TABLE company
(
    id   INT,
    name VARCHAR(128),
    date DATE
);

INSERT INTO company (id, name, date)
VALUES (1, 'Google', '2001-01-01'),
       (2, 'Apple', '2002-10-29'),
       (3, 'Facebook', '1998-09-13');
```

## Constraints в PostgreSQL

**Ограничения позволяют избежать ошибок**

Например, если мы храним обычную цену и цену со скидкой, то мы можем гарантировать, что цена со скидкой будет всегда
меньше обычной:

```postgresql
CREATE TABLE products
(
    product_no       integer,
    name             text,
    price            numeric CHECK (price > 0),
    discounted_price numeric CHECK (discounted_price > 0),
    CHECK (price > discounted_price)
);
```

*Из примера выше видно, что ограничение-проверка может ссылаться на несколько столбцов.*

### Ключевое слово CONSTRAINT

*Это ключевое слово используется для создания именованного ограничения:*

```postgresql
CREATE TABLE products
(
    product_no integer,
    name       text,
    price      numeric
        CONSTRAINT positive_price CHECK (price > 0)
);
```

```postgresql
CREATE TABLE company
(
    id   INT PRIMARY KEY,
    name VARCHAR(128) UNIQUE NOT NULL,
    date DATE CHECK ( date > '2000-01-01' AND date < '2023-05-07' )
);
```

### NOT NULL

*Ограничение NOT NULL в PostgreSQL гарантирует, что столбец не может содержать никаких нулевых значений.*

![img_3.png](src/photos/img_3.png)

### UNIQUE

*Ограничения уникальности гарантируют, что данные в определённом столбце или группе столбцов уникальны среди всех строк
таблицы.*

![img_4.png](src/photos/img_4.png)

При добавлении ограничения уникальности будет автоматически создан уникальный индекс B-дерева для столбца или группы
столбцов, перечисленных в ограничении.

### CHECK

*Ограничение-проверка - наиболее общий тип ограничений. В его определении вы можете указать, что значение данного
столбца должно удовлетворять логическому выражению (проверке истинности).*

![img_5.png](src/photos/img_5.png)

### PRIMARY KEY

*Ограничение первичного ключа означает, что образующий его столбец или группа столбцов может быть уникальным
идентификатором строк в таблице*

**Для этого требуется, чтобы значения были одновременно уникальными и отличными от NULL.**

```postgresql
CREATE TABLE products
(
    product_no INT UNIQUE NOT NULL,
    name       TEXT,
    price      NUMERIC
);
CREATE TABLE products
(
    product_no INT PRIMARY KEY,
    name       TEXT,
    price      NUMERIC
);
```

При добавлении первичного ключа автоматически создаётся уникальный индекс B-дерева для столбца или группы столбцов,
перечисленных в первичном ключе, и данные столбца помечаются как NOT NULL.

## Sequence in PostgreSQL

*В PostgreSQL последовательность - это особый тип объекта базы данный, который генерирует последовательность целых
чисел.*

```postgresql
CREATE TABLE company
(
    id SERIAL
);
```

## Операция SELECT

*Операция SELECT позволяет получить строки из таблицы или представления.*

Пример вывода всех полей таблицы:

```postgresql
SELECT *
FROM company;
```

## Alias в PostgreSQL

Псевдонимы таблиц временно назначают таблицам новые имена во время выполнения запроса.

Пример использования псевдонима:

```postgresql
SELECT id,
       name AS alias_name,
       date
FROM company AS com;
```

## Ключевое слово DISTINCT

*Ключевое слово DISTINCT используется в операции SELECT для удаления повторяющихся строк из набора результатов.
Предложение
DISTINCT сохраняет одну строку для каждой группы дубликатов. Ключевое слово DISTINCT может быть применимо к одному или
нескольким
столбцам в списке выборки операции SELECT.*

Пример использования DISTINCT:

![img_6.png](src/photos/img_6.png)

## Ключевое слово WHERE

*Оператор SELECT возвращает все строки из одного или нескольких столбцов таблицы. Чтобы выбрать строки, удовлетворяющие
заданному условию, следует использовать WHERE.*

Пример использования *WHERE*:

```postgresql
SELECT *
FROM employee
WHERE salary > 1500;
```

## Ключевое слово LIKE, ILIKE и BETWEEN

*Выражение LIKE возвращает true, если строка соответствует заданному шаблону.*

'Ivanov' LIKE '%ov%' - *true* <br/>
'Ivanov' LIKE '%ov_' - *false* <br/>
'Svetikova' LIKE '%ov_' - *true* <br/>

*Ключевое слово ILIKE используется для того, чтобы поиск был регистр-независимым*

*Условие BETWEEN используется для получения значений в диапазоне:*

```postgresql
SELECT *
FROM employee
WHERE salary BETWEEN 1200 AND 2100;
```

*Для нахождения конкретного значения, используется ключевое слово **IN***.

```postgresql
SELECT *
FROM employee
WHERE salary IN (500, 1000);
```

## Foreign key

*Внешний ключ - это столбец или группа столбцов, которые ссылаются на первичный ключ другой таблицы .*

Пример использования внешнего ключа на другую таблицу:

```postgresql
CREATE TABLE company
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(128) UNIQUE NOT NULL,
    date DATE CHECK ( date > '2000-01-01' AND date < '2023-05-07' )
);

CREATE TABLE employee
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    company_id INT REFERENCES company (id),
    salary     INT,
    UNIQUE (first_name, last_name)
);
```

*Внешний ключ позволяет обезопасить работу с таблицами.*

![img_10.png](src/photos/img_10.png)

## Агрегатные и встроенные функции

### 5 функций, которые представлены во всех СУБД: *sum, avg, max, min, count*.

*1) Функция **sum()** используется для суммирования значений столбцов:*

```postgresql
SELECT sum(salary)
FROM employee;
```

![img_7.png](src/photos/img_7.png)

*2) Также присутствуют функции avg() - для нахождения среднего значения, max() - для нахождения максимального значения,
min() - для нахождения минимального.*

*3) Функция **count()** позволяет получить количество полей в таблице.*

• count(*) - ищет все записи, которые вернулись. <br/>
• count(salary) - ищет записи по определённому столбу. Если по определённому столбцу вернулся *null*, то значение не
учитывается.

*4) Функция **upper()** - применяется для возведения данных поля в верхний регистр, **lower()** - в нижний.*

```postgresql
SELECT upper(first_name) AS upperName,
       lower(last_name)  AS lowerSurname
FROM employee;
```

![img_8.png](src/photos/img_8.png)

*5) Функция **concat()** используется для конкатенации строк.*

```postgresql
SELECT concat(first_name, ' ', last_name) AS concat
FROM employee
```

![img_9.png](src/photos/img_9.png)

### Примечание:

*Всегда, когда мы хотим проверить поле на **NULL**, нам необходимо использовать ключевое слово IS:*

```postgresql
SELECT first_name
FROM employee
WHERE company_id IS NULL;
```

## Объединение множеств. UNION

*Оператор UNION используется для объединения результирующих наборов из 2 и более операторов
SELECT. **Он удаляет повторяющиеся строки между различными операторами SELECT.***

*Каждый оператор SELECT в операторе UNION должен иметь одинаковое количество полей в наборах результатов с одинаковыми
типами данных.*

Пример использования UNION:

*Первое множество:*

```postgresql
SELECT first_name
FROM employee
WHERE company_id IS NOT NULL
```

![img_11.png](src/photos/img_11.png)

*Второе множество:*

```postgresql
SELECT first_name
FROM employee
WHERE salary IS NULL
```

![img_12.png](src/photos/img_12.png)

**Результат объединения UNION:**

```postgresql
SELECT first_name
FROM employee
WHERE company_id IS NOT NULL
UNION
SELECT first_name
FROM employee
WHERE salary IS NULL
```

![img_13.png](src/photos/img_13.png)

## Объединение множеств. UNION ALL

*Оператор UNION ALL используется для объединения результирующих наборов из 2 и более операторов SELECT. Он возвращает
все строки из запроса и не удаляет повторяющиеся строки между различными операторами SELECT.*

*Каждый оператор SELECT в операторе UNION ALL должен иметь одинаковое количество полей в наборах результатов с
одинаковыми типами данных.*

```postgresql
SELECT first_name
FROM employee
WHERE company_id IS NOT NULL
UNION ALL
SELECT first_name
FROM employee
WHERE salary IS NULL
```

**Результат объединения UNION ALL:**

![img_14.png](src/photos/img_14.png)

## Подзапросы

*Подзапросы (subquery) представляют собой такие запросы, которые могут быть встроены в другие запросы.*

Примеры:

```postgresql
SELECT avg(empl.salary)
FROM (SELECT *
      FROM employee
      ORDER BY salary
      LIMIT 2) empl;
```

```postgresql
SELECT *,
       (SELECT avg(salary) FROM employee) - salary diff
FROM employee;
```

```postgresql
SELECT *
FROM employee
WHERE company_id IN (SELECT company.id FROM company WHERE date < '2005-02-02')
```

## Команда DELETE

*Команда DELETE удаляет из указанной таблицы строки.*

Пример использования команды DELETE:

```postgresql
DELETE
FROM employee
WHERE salary IN (SELECT min(salary) FROM employee);
```

При попытке удаления таблица, на которую ссылаются другие таблицы, мы получим ошибку

![img_15.png](src/photos/img_15.png)

Для обхода ошибки необходимо удалить таблицу, которая ссылается на исходную.

![img_16.png](src/photos/img_16.png)

### Ограничение проверки ON DELETE

• **ON DELETE CASCADE** - во время удаления одной из таблиц, связанная таблица удаляется. <br/>
• **SET DEFAULT** - указание значения по умолчания в случае удаления. <br/>
• **SET NULL** - установление значения NULL в случае удаления.

## Команда UPDATE

*Команда UPDATE изменяет значения указанных столбцов во всех строках, удовлетворяющих условию. В предложении SET должны
указываться только те столбцы, которые будут изменены.*

Пример использования команды UPDATE:

```postgresql
UPDATE employee
SET id     = 3,
    salary = 1000
WHERE id = 10;
```

В случае отсутствия ключевого слова WHERE, изменения применяются ко всем полям таблицы.

*Предложение RETURNING указывает, что команда UPDATE должна вычислить и возвратить значения для каждой фактически
изменённой строки.*

Пример использования предложения RETURNING:

![img_17.png](src/photos/img_17.png)