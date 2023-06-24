# SQL

![img.png](img.png)

## Базы данных

**• Предназначены для долговременного хранения информации.** <br/>
**• Позволяют быстро находить нужные данные, так как обладают встроенными средствами поиска.** <br/>
**• Реляционные базы используют табличную структуру для хранения данных, а для работы с ними используют язык SQL.**

## СУБД

*СУБД - это всего лишь приложение, способное манипулировать данными.*

![img_1.png](img_1.png)

**• Система управления базами данных. Например: MySQL, PostgreSQL, Oracle, MsSQL.** <br/>
**• «Надстройка» над базами данных, организующая работу с БД и добавляющая дополнительную функциональность.** <br/>
**• Каждая СУБД обладает своими отличиями. Например, встроенными типами данных.** <br/>
**• Каждая СУБД снабжена своим процедурным языком программирования.**

## DDL & DML

![img_2.png](img_2.png)

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

![img_3.png](img_3.png)

### UNIQUE

*Ограничения уникальности гарантируют, что данные в определённом столбце или группе столбцов уникальны среди всех строк
таблицы.*

![img_4.png](img_4.png)

При добавлении ограничения уникальности будет автоматически создан уникальный индекс B-дерева для столбца или группы
столбцов, перечисленных в ограничении.

### CHECK

*Ограничение-проверка - наиболее общий тип ограничений. В его определении вы можете указать, что значение данного
столбца должно удовлетворять логическому выражению (проверке истинности).*

![img_5.png](img_5.png)

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

![img_6.png](img_6.png)

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

![img_10.png](img_10.png)

## Агрегатные и встроенные функции

### 5 функций, которые представлены во всех СУБД: *sum, avg, max, min, count*.

*1) Функция **sum()** используется для суммирования значений столбцов:*

```postgresql
SELECT sum(salary)
FROM employee;
```

![img_7.png](img_7.png)

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

![img_8.png](img_8.png)

*5) Функция **concat()** используется для конкатенации строк.*

```postgresql
SELECT concat(first_name, ' ', last_name) AS concat
FROM employee
```

![img_9.png](img_9.png)

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

![img_11.png](img_11.png)

*Второе множество:*

```postgresql
SELECT first_name
FROM employee
WHERE salary IS NULL
```

![img_12.png](img_12.png)

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

![img_13.png](img_13.png)

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

![img_14.png](img_14.png)

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

![img_15.png](img_15.png)

Для обхода ошибки необходимо удалить таблицу, которая ссылается на исходную.

![img_16.png](img_16.png)

### Ограничение проверки ON DELETE

• **ON DELETE CASCADE** - во время удаления одной из таблиц, связанная таблица удаляется. <br/>
• **SET DEFAULT** - указание значения по умолчания в случае удаления. <br/>
• **SET NULL** - установление значения NULL в случае удаления. <br/>
• **RESTRICT** - поведение по умолчанию.

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

![img_17.png](img_17.png)

## Операция ALTER

### Операция ADD COLUMN позволяет добавить новую колонку в таблицу 

```postgresql
CREATE TABLE "Order"
(
    id      INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    age     INT         NOT NULL,
    name_as VARCHAR(30) NOT NULL UNIQUE
);

ALTER TABLE IF EXISTS "Order"
    ADD COLUMN gender INT;
```

### Операция DROP COLUMN позволяет удалить колонку

```postgresql
ALTER TABLE "Order"
    DROP COLUMN gender;
```

# Нормализация баз данных

**Реляционная база данных - это упорядоченная информация, связанная между собой определёнными отношениями.**

![img.png](img_18.png)

**Нормализация** - метод проектирования базы данных, который позволяет привести базу данных к минимальной избыточности.

**Избыточность данных** - это когда одни и те же данные хранятся в базе в нескольких местах (таблицах), именно это и
приводит к различным аномалиям.

*Пример аномалии:*

![img_1.png](img_19.png)

*Проблема:* Отсутствие ограничение на столбец *company*. Добавляя нового сотрудника, мы можем ошибиться во вводе
компании.

![img_2.png](img_20.png)

*Решение проблемы:* Создание отдельной таблицы.

![img_3.png](img_21.png)

**Нормальная форма базы данных** - это набор правил и критериев, которым должна отвечать база данных.

## Перечень нормальных форм:

![img_4.png](img_22.png)

*На практике обычно используется Первая - Третья нормальные формы.*

## Требования первой нормальной формы (1НФ)

Чтобы база данных находилась в первой нормальной форме (1НФ), необходимо чтобы её таблицы соблюдали следующие
реляционные принципы:

1. В таблице не должно быть дублирующих строк.
2. В каждой ячейке таблицы хранится атомарное значение.
3. В столбце хранятся данные одного типа.

Пример несоблюдения требований первой нормальной формы:

![img_5.png](img_23.png)

*Решение:*

![img_6.png](img_24.png)

## Требования второй нормальной формы (2НФ)

Чтобы база данных находилась во второй нормальной форме (2НФ), необходимо чтобы её таблицы удовлетворяли следующих
требованиям:

1. Таблица должна находиться в первой нормальной форме.
2. Таблица должна иметь первичный ключ *(PRIMARY KEY)*.
3. Все неключевые столбцы таблица должны зависеть от полного первичного ключа (в случае если он составной).

*Решение:*

![img_7.png](img_25.png)

*Как делать нельзя:*

![img_8.png](img_26.png)

*Неключевым столбцам достаточно ссылаться на id.*

## Требования третьей нормальной формы (3НФ)

Чтобы база данных находилась в третьей нормальной форме (3НФ), необходимо чтобы её таблицы удовлетворяли следующим
требованиям:

1. Таблица должна находиться во второй нормальной форме.
2. В таблице должна отсутствовать транзитивная зависимость неключевых столбцов.

![img_27.png](img_27.png)

***contact_type** никак не относится к employee, а относится к contact.*

*Решение - декомпозиция*

**Декомпозиция - это процесс разбиения одной таблицы на несколько.**

![img_28.png](img_28.png)

### Итог:

**1НФ** - наше внимание нацелено на соблюдение простейших реляционных принципов (нет дублирования и атомарные значения в
ячейках).

**2НФ** - наше внимание нацелено на первичный ключ.

**3НФ** - наше внимание нацелено на неключевые столбцы.

## Связи между таблицами в реляционных базах данных

*Для связывания таблиц обычно используется первичный ключ **PRIMARY KEY** (реже уникальное поле **UNIQUE**) одной
таблицы и внешний ключ **FOREIGN KEY** второй таблицы.*

**Выделяют 3 вида связей между таблицами в реляционных базах данных.**

1. Один ко многим
2. Один к одному
3. Многие ко многим

### Один ко многим

![img_29.png](img_29.png)

![img_33.png](img_33.png)

Мы как бы ссылаемся из Contact на Employee. Делается это потому, что у одного сотрудника может быть несколько контактов.

То есть один employee относится к множеству контактов.

**PRIMARY KEY содержит только уникальные значения, FOREIGN KEY может содержать дубликаты.**

**Таблица, содержащая FOREIGN KEY - дочерняя. Таблица, содержащая только PRIMARY KEY - родительская.**

**Один заказ не может принадлежать нескольким людям, так как на *order_id* ограничение PRIMARY KEY.**

*Пример:* Покупатель и заказы, учитель и ученики, библиотека и книги, режиссёр и его фильмы.

****

### Один к одному

![img_30.png](img_30.png)

![img_34.png](img_34.png)

Одна строчка таблицы Contact может ссылаться только на одного сотрудника из таблицы Employee, либо не ссылаться на него
вовсе.

*Другой вариант:*

![img_31.png](img_31.png)

*Другой вариант:*

![img_35.png](img_35.png)

**В таблице Passport *FK=PK*.**

**Человек может существовать без паспорта (Parent), но паспорт не может существовать без человека (Child).**

**Колонка *person_id* имеет ограничение PRIMARY KEY, поэтому у человека может быть только один паспорт.**

*Пример:* президент и страна, директор и школа.

****

### Многие ко многим

![img_32.png](img_32.png)

![img_36.png](img_36.png)

![img_37.png](img_37.png)

*Пример:* учёные и научные статьи, студенты и занятия.

****

# Связывание таблиц (Database joins)

• Наши нормализованные таблицы эффективно хранят данные, но нам тяжело воспринимать данные

• Мы хотим **временно** слить таблицы в одну (не создавая новых таблиц), чтобы удобно посмотреть все данные и
взаимоотношения.

![img_38.png](img_38.png)

*Таблица не создаётся в БД (видная нам только для чтения)*

*Вариант получения данных без использования JOIN:*

```postgresql
SELECT Person.name name,
       Order.item_name
FROM Person,
     Order
WHERE Person.user_id = Order.order_id;
```

**Виды JOIN'ов:**

• INNER JOIN <br/>
• CROSS JOIN <br/>
• LEFT OUTER JOIN <br/>
• RIGHT OUTER JOIN <br/>
• FULL OUTER JOIN <br/>

### JOIN

*INNER JOIN представляет из себя внутреннее соединение.*

```postgresql
SELECT P.name name,
       O.item_name
FROM Person P
         JOIN Order_ O on P.user_id = O.user_id
```

![img_39.png](img_39.png)

Стоит заметить, что поле Nick не нашло себе пары, поэтому JOIN его проигнорировал.

![img_40.png](img_40.png)

### CROSS JOIN

*CROSS JOIN представляет из себя перекрёстное соединение набора строк, где каждая строка из одной таблицы соединяется с
каждой строкой из второй таблицы.*

![img_44.png](img_44.png)

```postgresql
SELECT *
FROM Person AS P
         CROSS JOIN
     Order_ AS O;
```

Возвращает Декартово (или прямое) произведение двух таблиц

### LEFT OUTER JOIN

*Возвращает все строки таблицы в левой части соединения и соответствующие строки для таблицы в правой части
соединения. **Строки, для которых нет соответствующей строки с правой стороны, результирующий набор будет содержать
null.***

![img_42.png](img_42.png)

```postgresql
SELECT *
FROM Person P
         LEFT JOIN Order_ O on P.user_id = O.user_id;
```

![img_41.png](img_41.png)

### RIGHT OUTER JOIN

![img_43.png](img_43.png)

### FULL OUTER JOIN

*Является объединением запросов LEFT OUTER JOIN и RIGHT OUTER JOIN.*

### Отличие CROSS JOIN от FULL OUTER JOIN

FULL OUTER JOIN соединяет одну строку первой таблицы с определённой строкой второй таблицы, а при CROSS JOIN каждая
строка одной таблицы соединяется с каждой строкой другой таблицы.

## Когда использовать INNER JOIN, а когда LEFT JOIN?

### Зависит от задачи:

1) Выведи всех пользователей, которые указали адрес -> INNER JOIN (более строгий - выведутся только пользователи, у
   которых найдётся пара из таблицы Address).
2) Выведи всю доступную информацию обо всех пользователей -> LEFT JOIN (менее строгий - выведутся все пользователи, а
   тех, у кого нет адреса, будут *null'ы* в колонках адреса).

## Группировки запросов. GROUP BY & HAVING

### Проблема

Пусть на поле Nick не ссылается ни один из заказов. То есть при попытке определить количество заказов у Nick, мы должны
получить значение 0. Однако при использовании функции *count()* мы получаем значение 1, поскольку null также считается
валидной колонкой.

```postgresql
SELECT count(*)
FROM person
         LEFT OUTER JOIN order_ o on person.user_id = o.user_id
WHERE name = 'Nick';
```

![img_45.png](img_45.png)

![img_46.png](img_46.png)

Это можно решить, вызвав функции count() на поле id, однако у нас пропадет возможность вывода названия компании, потому что это не агрегирующая функция.

![img_47.png](img_47.png)

Для этого используется GROUP BY, в котором мы указываем, какие поля хотим видеть в выводе вместе с агрегирующей функцией.

```postgresql
SELECT p.name, count(o.user_id)
FROM person p
         LEFT OUTER JOIN order_ o on p.user_id = o.user_id
WHERE p.name = 'Nick'
GROUP BY p.id;
```

*В случае агрегирования по id, мы можем перечислять все колонки*

```postgresql
SELECT p.name, p.user_id, count(o.user_id)
FROM person p
         LEFT OUTER JOIN order_ o on p.user_id = o.user_id
WHERE p.name = 'Nick'
GROUP BY p.user_id;
```

![img_48.png](img_48.png)

GROUP BY позволяет схлопывать только те записи, которые относятся к одному ключу группировки.

```postgresql
SELECT p.name, count(o.user_id)
FROM person p
         LEFT OUTER JOIN order_ o on p.user_id = o.user_id
GROUP BY p.user_id;
```

![img_49.png](img_49.png)

### Ключевое слово HAVING

*Для наложения каких-либо условий для результата схлопывания GROUP BY, используется HAVING:*

```postgresql
SELECT p.name, count(*)
FROM person p
         LEFT OUTER JOIN order_ o on p.user_id = o.user_id
GROUP BY p.user_id
HAVING count(p.user_id) > 3;
```

![img_50.png](img_50.png)

**WHERE мы используем в запросе для строк. GROUP BY группирует наши строки и с помощью HAVING мы можем накладывать условия на уже сформировавшиеся строки.**

# Индексы. B-Tree.

## Без индекса - примеры медленных запросов

![img_51.png](img_51.png)

## Как команды работают без индекса?

• Значения в колонке *amount* расположены хаотично (неупорядоченно).

• Запросы, которые используют эту колонку, будут заставлять БД проходиться по всем значениям колонки.

• Нам необходимо ускорить запросы, использующие колонку *amount*.

• На этой колонке необходимо создать индекс!

## Индекс

![img_52.png](img_52.png)

**Теперь для этих запросов БД может использовать не обычный линейный поиск, а более быстрые алгоритмы, например двоичный поиск.**

![img_53.png](img_53.png)

## Индексы в PostgreSQL

**CREATE INDEX ON Transaction (amount) USING ???**

• PRIMARY KEY - **Первичный ключ индексируется по умолчанию**

• B-Tree Index

• Hash Index

• Gin & Gist Index

• BRIN Index

**Все индексы упорядочивают данные тем или иным способом, чтобы ускорить поиск по этим данным.**

# Hibernate

### Варианты связывания Java-приложения с БД:

![img_54.png](img_54.png)

## Наблюдение

![img_55.png](img_55.png)

### Классы похожи на таблицы в реляционных БД. Благодаря этому были придуманы ORM

![img_56.png](img_56.png)

## Связь между сущностями

![img_57.png](img_57.png)

## Сущности в Hibernate

### Сессия (Session)

#### Объект для взаимодействия с Hibernate. Когда хотим что-то делать с БД через Hibernate - получаем сессию. Объект Session получаем из объекта SessionFactory (паттерн фабрика)

```java
SessionFactory sessionFactory = configuration.buildSessionFactory();

Session session = sessionFactory.getCurrentSession();
```

#### На объекте Session можно вызывать:

##### • save
##### • update
##### • get
##### • ...

## Транзакция

### Единица работы с БД

![img_58.png](img_58.png)

• Нужны для поддержания согласованности данных в таблице <br/>
• Транзакции могут блокировать доступ к БД (примеры: пока я пишу в таблицу, не читай значения из неё, пока я обновляю человека его нельзя обновлять, пока я удаляю строки в таблице нельзя получить все строки из таблицы)
• Транзакции можно применять (COMMIT) и откатывать (ROLLBACK)

*Транзакция на примере:*

![img_59.png](img_59.png)

### ACID

*Набор свойств, которыми должна обладать транзакция БД*
#### A - Atomicity (Атомарность)
#### C - Consistency (Согласованность)
#### I - Isolation (Изоляция)
#### D - Durability (Устойчивость)

### Atomicity

**Атомарность** гарантирует, что никакая транзакция не будет зафиксирована в системе частично.

Будут либо выполнены все её подоперации, либо не выполнено ни одной.

### Consistency

**Согласованность** - каждая успешная транзакция фиксирует только допустимые результаты.

### Isolation

**Изолированность** - во время выполнения транзакции параллельные транзакции не должны оказывать влияние на её результат.

### Durability

**Устойчивость** - независимо от проблем на нижних уровнях изменения, сделанные успешно завершённой транзакцией, должны остаться сохранёнными после возвращения системы в работу.

### Transaction isolation issues

• **Lost Update** - потерянное обновление<br/>
• **Dirty Read** - "грязное" чтение<br/>
• **Non-Repeatable Read** - неповторяющееся чтение<br/>
• **Phantom Read** - фантомное чтение<br/>

### Lost Update

Происходит, когда обе транзакции одновременно обновляют данные и затем вторая транзакция откатывает изменения, вследствие чего изменения обеих транзакций теряются

![img_60.png](img_60.png)

### Dirty Read

Происходит, когда первая транзакция читает изменения, сделанные другой транзакцией, но эти изменения ещё не были закоммичены. После чего вторая транзакция откатывает эти изменения, а первая продолжает работу с "грязными" данными.

![img_61.png](img_61.png)

### Non-Repeatable Read

Происходит, когда первая транзакция читает одни и те же данные дважды, но после первого прочтения вторая транзакция изменяет (update) эти же данные и делает коммит, вследствие чего вторая выборка в первой транзакции вернёт другой результат.

![img_62.png](img_62.png)

*Существует особый случай Non-Repeatable Read называемый **last commit wins**, когда обе транзакции читают одни и те же данные, но первая успевает изменить и закоммитить их раньше, чем произойдёт изменение и коммит во второй транзакции, вследствие чего изменения первой транзакции теряются*

![img_63.png](img_63.png)

### Phantom Read

Происходит, когда первая транзакция читает одни и те же данные дважды, но после первого прочтения вторая транзакция добавляет новые строки или удаляет старые и делает коммит, вследствие чего вторая выборка в первой транзакции вернёт другой результат (разное количество записей).

![img_64.png](img_64.png)

## Уровни изолированности транзакций

![img_65.png](img_65.png)

## Уровни изолированности транзакций (PostgreSQL)

![img_66.png](img_66.png)

# HQL

Для некоторых задач приходится писать запросы. **Для этого в Hibernate используется свой язык запросов - HQL**

![img_67.png](img_67.png)

**В SQL мы работаем с таблицами, в HQL с сущностями (Java-классы).**

• Был разработан, чтобы мы не спускались до уровня таблиц, а делали запрос, используя сущности (Java-классы).<br/>
• Конвертируется в HQL.<br/>
• В Hibernate можно использовать и обычный SQL для сложных запросов, но лучше HQL.<br/>
• Spring-приложение - это обычно комбинация Hibernate (+Spring Data JPA) и SQL для нестандартных запросов.<br/>

## Отношение Один ко многим в Hibernate

![img_68.png](img_68.png)

### Для выстраивания отношений между сущностями, в Hibernate существуют аннотации @OneToMany, @ManyToOne и @JoinColumn

![img_69.png](img_69.png)

## Жизненный цикл сущности в Hibernate

**Java объекты-сущности проходят через несколько состояний, когда мы используем Hibernate**

#### • Transient
#### • Persistent (Managed)
#### • Detached
#### • Removed