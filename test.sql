-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Сен 17 2021 г., 05:12
-- Версия сервера: 10.4.21-MariaDB
-- Версия PHP: 7.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `resource`
--

CREATE TABLE `resource` (
  `resource_id` bigint(20) NOT NULL,
  `resource_name` varchar(255) DEFAULT NULL,
  `resource_url` varchar(255) DEFAULT NULL,
  `top-tag` varchar(255) NOT NULL,
  `top-tag-add` varchar(255) NOT NULL,
  `bottom-tag` varchar(255) NOT NULL,
  `bottom-tag-add` varchar(255) NOT NULL,
  `title-cut` varchar(255) NOT NULL,
  `title-cut-add` varchar(255) NOT NULL,
  `date-cut` varchar(255) NOT NULL,
  `date-cut-add` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `resource`
--

INSERT INTO `resource` (`resource_id`, `resource_name`, `resource_url`, `top-tag`, `top-tag-add`, `bottom-tag`, `bottom-tag-add`, `title-cut`, `title-cut-add`, `date-cut`, `date-cut-add`) VALUES
(1, 'nur.kz', 'https://www.nur.kz/', 'li', 'block-top-hero__item', 'h3', '', 'span', 'preview-info-item-primary', 'time', 'preview-info-item-secondary');

-- --------------------------------------------------------

--
-- Структура таблицы `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `content` text NOT NULL,
  `datetime` text NOT NULL,
  `url` text NOT NULL,
  `res_id` bigint(20) NOT NULL,
  `nd_date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `resource`
--
ALTER TABLE `resource`
  ADD PRIMARY KEY (`resource_id`);

--
-- Индексы таблицы `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `res_id` (`res_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `resource`
--
ALTER TABLE `resource`
  MODIFY `resource_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=268;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `test_ibfk_1` FOREIGN KEY (`res_id`) REFERENCES `resource` (`resource_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
