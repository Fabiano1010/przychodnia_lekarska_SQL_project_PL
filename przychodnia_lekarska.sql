-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 03 Sty 2023, 20:39
-- Wersja serwera: 10.4.25-MariaDB
-- Wersja PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `przychodnia_lekarska`
--

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `ilosc_lekow_przeznaczenie`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `ilosc_lekow_przeznaczenie` (
`ilosc_lekow` bigint(21)
,`przeznaczenie` text
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `ilosc_sredni_wzrost_k`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `ilosc_sredni_wzrost_k` (
`kobiety` bigint(21)
,`sredni_wzrost` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `leki`
--

CREATE TABLE `leki` (
  `id` int(10) UNSIGNED NOT NULL,
  `nazwa` varchar(60) COLLATE utf8mb4_polish_ci NOT NULL,
  `przeznaczenie` text COLLATE utf8mb4_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `leki`
--

INSERT INTO `leki` (`id`, `nazwa`, `przeznaczenie`) VALUES
(1, 'Alergic', 'przeciw alergiczne'),
(2, 'Apap', 'przeciwbólowe'),
(3, 'Paracetamol', 'przeciwbólowe'),
(4, 'Allerga', 'przeciw alergiczne'),
(5, 'Lokomotiv', 'choroba lokomocyjna'),
(6, 'Acard', 'krążenie'),
(7, 'Metocard', 'krążenie'),
(8, 'Polocard', 'krążenie'),
(9, 'Acatar', 'przeziebienie/grypa'),
(10, 'Aspiryna', 'przeziebienie/grypa'),
(11, 'Szczepionka tężec', 'szczepienie'),
(12, 'Insulina', 'cukrzyca'),
(13, 'Theraflu', 'przeziebienie/grypa'),
(14, 'Ibuprofen', 'przeciwbólowy');

--
-- Wyzwalacze `leki`
--
DELIMITER $$
CREATE TRIGGER `usuwanie_leki` AFTER DELETE ON `leki` FOR EACH ROW BEGIN
    	DELETE FROM recepty WHERE id_lek=old.id;
	END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `zmiana_leki` AFTER UPDATE ON `leki` FOR EACH ROW BEGIN
    	UPDATE recepty SET id_lek=new.id WHERE id_lek=old.id;
	END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `leki_na_a`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `leki_na_a` (
`nazwa` varchar(60)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `najwcześniej_zatrudniony_najstarszy_pracownik`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `najwcześniej_zatrudniony_najstarszy_pracownik` (
`najwcześniej_zatrudniony` date
,`najstarszy_pracownik` date
,`imie` varchar(40)
,`nazwisko` varchar(50)
,`stanowisko` varchar(60)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pacjenci`
--

CREATE TABLE `pacjenci` (
  `id` int(10) UNSIGNED NOT NULL,
  `imie` varchar(40) COLLATE utf8mb4_polish_ci NOT NULL,
  `nazwisko` varchar(50) COLLATE utf8mb4_polish_ci NOT NULL,
  `pesel` varchar(11) COLLATE utf8mb4_polish_ci NOT NULL,
  `data_urodzenia` date NOT NULL,
  `waga` int(11) NOT NULL,
  `wzrost` int(11) NOT NULL,
  `plec` enum('k','m') COLLATE utf8mb4_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `pacjenci`
--

INSERT INTO `pacjenci` (`id`, `imie`, `nazwisko`, `pesel`, `data_urodzenia`, `waga`, `wzrost`, `plec`) VALUES
(1, 'Bronisław', 'Wróblewski', '27022081019', '1927-02-20', 89, 179, 'm'),
(2, 'Jolanta', 'Dudek', '31053115285', '1931-05-31', 66, 162, 'k'),
(3, 'Daria', 'Nowicka', '23122772264', '1923-12-27', 83, 168, 'k'),
(4, 'Leon', 'Kozieł', '03322728072', '2003-12-27', 52, 173, 'm'),
(5, 'Franciszek', 'Duda', '98070951072', '1998-07-09', 66, 156, 'm'),
(6, 'Zuzanna', 'Markiewicz', '89062119282', '1989-06-21', 97, 164, 'k'),
(7, 'Wiktor', 'Olejniczak', '45070799997', '1945-07-07', 110, 168, 'm'),
(8, 'Wiesław', 'Nowicki', '89071382855', '1989-07-13', 48, 158, 'm'),
(9, 'Sławomir', 'Zając', '60011458593', '1960-01-14', 67, 183, 'm'),
(10, 'Łucja', 'Bednarek', '75121134323', '1975-12-11', 85, 155, 'k'),
(11, 'Ireneusz', 'Świątek', '53122255492', '1953-12-22', 55, 188, 'm'),
(12, 'Mirosław', 'Wysocki', '91112759799', '1991-11-27', 95, 181, 'm'),
(13, 'Paula', 'Bednarczyk', '91021440900', '1991-02-14', 69, 188, 'k'),
(14, 'Gertruda', 'Sobolewska', '02252255441', '2002-05-22', 88, 183, 'k'),
(15, 'Witold', 'Wilczyński', '54083051998', '1954-08-30', 60, 170, 'm'),
(16, 'Anastazja', 'Rogowska', '60123193683', '1960-12-31', 98, 171, 'k'),
(17, 'Milena', 'Woźniak', '80020169442', '1980-02-01', 72, 169, 'k'),
(18, 'Bernadeta', 'Piasecka', '78050693648', '1978-05-06', 74, 155, 'k'),
(19, 'Pelagia', 'Nowak', '00260892441', '2000-06-08', 107, 176, 'k'),
(20, 'Aneta', 'Sokołowska', '85040300620', '1985-04-03', 75, 171, 'k'),
(21, 'Mariola', 'Kołodziejczyk', '91011059262', '1991-01-10', 71, 181, 'k'),
(22, 'Mariusz', 'Kozieł', '68032140796', '1968-03-21', 94, 175, 'm'),
(23, 'Ryszard', 'Wierzbicki', '94102559078', '1994-10-25', 95, 169, 'm'),
(24, 'Franciszek', 'Krajewski', '58051708750', '1958-05-17', 72, 182, 'm'),
(25, 'Beata', 'Kucharska', '73081112683', '1973-08-11', 96, 175, 'k');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `pacjenci_nazwisko_k`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `pacjenci_nazwisko_k` (
`nazwisko` varchar(50)
,`pesel` varchar(11)
,`plec` enum('k','m')
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `personel`
--

CREATE TABLE `personel` (
  `id` int(10) UNSIGNED NOT NULL,
  `imie` varchar(40) COLLATE utf8mb4_polish_ci NOT NULL,
  `nazwisko` varchar(50) COLLATE utf8mb4_polish_ci NOT NULL,
  `data_urodzenia` date NOT NULL,
  `data_zatrudnienia` date NOT NULL,
  `id_stanowisko` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `personel`
--

INSERT INTO `personel` (`id`, `imie`, `nazwisko`, `data_urodzenia`, `data_zatrudnienia`, `id_stanowisko`) VALUES
(1, 'Żaneta', 'Olejniczak', '1989-05-26', '2010-01-01', 1),
(2, 'Borys', 'Kucharski', '1966-03-17', '2010-03-01', 1),
(3, 'Milena', 'Adamczyk', '1972-08-28', '2010-04-22', 1),
(4, 'Dorota', 'Brzezińska', '1977-10-07', '2011-02-01', 1),
(5, 'Ludwika', 'Baranowska', '1968-12-25', '2010-01-26', 1),
(6, 'Cyprian', 'Kaczmarczyk', '1988-12-28', '2010-02-01', 1),
(7, 'Zbigniew', 'Wróblewski', '1993-08-27', '2010-01-01', 1),
(8, 'Grażyna', 'Olejniczak', '1981-11-04', '2015-03-10', 1),
(9, 'Ferdynand', 'Bielecki', '1974-08-24', '2010-02-09', 2),
(10, 'Sabina', 'Świątek', '1987-02-05', '2012-04-12', 2),
(11, 'Anastazja', 'Majchrzak', '1968-07-01', '2010-04-07', 2),
(12, 'Witold', 'Piasecki', '1993-12-04', '2010-01-06', 2),
(13, 'Kajetan', 'Duda', '1977-10-11', '2010-06-01', 2),
(14, 'Mateusz', 'Kaczmarek', '1986-03-04', '2010-10-01', 2),
(15, 'Malwina', 'Dziedzic', '1989-08-23', '2011-11-01', 2),
(16, 'Bogdan', 'Zając', '1964-02-15', '2014-03-01', 2),
(17, 'Arleta', 'Wróblewska', '1970-06-17', '2012-12-06', 1),
(18, 'Walenty', 'Kowalewski', '1988-09-23', '2014-01-02', 1),
(19, 'Kamila', 'Domagała', '1953-02-14', '2011-01-01', 3),
(20, 'Stefania', 'Orzechowska', '1992-02-26', '2013-02-06', 3),
(21, 'Aleksander', 'Kozieł', '1971-08-19', '2012-01-21', 3),
(22, 'Ilona', 'Kamińska', '1997-12-11', '2011-07-11', 3),
(23, 'Jakub', 'Gajda', '1953-09-04', '2013-08-21', 4),
(24, 'Stanisław', 'Makowski', '1995-09-18', '2012-01-11', 4);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `personel_wizyty`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `personel_wizyty` (
`imie` varchar(40)
,`nazwa` varchar(60)
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `przeznaczenie_lekow`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `przeznaczenie_lekow` (
`przeznaczenie` text
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `recepty`
--

CREATE TABLE `recepty` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_wizta` int(10) UNSIGNED NOT NULL,
  `id_lek` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `recepty`
--

INSERT INTO `recepty` (`id`, `id_wizta`, `id_lek`) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 4),
(4, 4, 5),
(5, 5, 6),
(6, 6, 7),
(7, 7, 10),
(8, 10, 8),
(9, 11, 14),
(10, 12, 2),
(11, 14, 13),
(12, 15, 11),
(13, 16, 11),
(14, 17, 11),
(15, 18, 11),
(16, 19, 2);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `recepty_pacjenci`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `recepty_pacjenci` (
`pacjent` varchar(91)
,`pesel` varchar(11)
,`id` int(10) unsigned
,`nazwa` varchar(60)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `sredni_wzrost_m`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `sredni_wzrost_m` (
`mezczyzni` bigint(21)
,`sredni_wzrost` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `sredni_wzrost_waga_k`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `sredni_wzrost_waga_k` (
`sredni_wzrost` decimal(14,4)
,`srednia_waga` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `stanowiska`
--

CREATE TABLE `stanowiska` (
  `id` int(10) UNSIGNED NOT NULL,
  `nazwa` varchar(60) COLLATE utf8mb4_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `stanowiska`
--

INSERT INTO `stanowiska` (`id`, `nazwa`) VALUES
(1, 'lekarz'),
(2, 'pielęgniarz'),
(3, 'sekretarz'),
(4, 'kierowca');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `stanowisko_personel_bez_wizyt`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `stanowisko_personel_bez_wizyt` (
`imie` varchar(40)
,`nazwa` varchar(60)
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wizyty`
--

CREATE TABLE `wizyty` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_pacjent` int(10) UNSIGNED NOT NULL,
  `id_personel` int(10) UNSIGNED NOT NULL,
  `rodzaj` varchar(50) COLLATE utf8mb4_polish_ci NOT NULL,
  `data_wizyty` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `wizyty`
--

INSERT INTO `wizyty` (`id`, `id_pacjent`, `id_personel`, `rodzaj`, `data_wizyty`) VALUES
(1, 1, 1, 'kontrola', '2022-12-12'),
(2, 2, 1, 'badanie', '2022-10-11'),
(3, 3, 1, 'wizyta wstępna', '2022-11-22'),
(4, 4, 1, 'wizyta wstępna', '2022-11-25'),
(5, 5, 2, 'wizyta wstępna', '2022-11-16'),
(6, 6, 1, 'badanie', '2022-12-18'),
(7, 7, 3, 'badanie', '2022-10-10'),
(8, 8, 17, 'skierowanie', '2022-11-13'),
(9, 9, 18, 'skierowanie', '2022-09-15'),
(10, 10, 8, 'kontrola', '2022-08-10'),
(11, 11, 8, 'badanie', '2022-11-22'),
(12, 12, 7, 'kontrola', '2022-10-18'),
(13, 13, 6, 'skierowanie', '2022-11-23'),
(14, 14, 6, 'badanie', '2022-11-10'),
(15, 15, 5, 'wizyta wstępna', '2022-12-17'),
(16, 16, 3, 'wizyta wstępna', '2022-11-13'),
(17, 17, 4, 'badanie', '2022-10-12'),
(18, 18, 2, 'badanie', '2022-09-05'),
(19, 19, 2, 'kontrola', '2022-08-08'),
(20, 20, 3, 'skierowanie', '2022-11-01'),
(21, 21, 9, 'szczepienie', '2022-11-17'),
(22, 22, 10, 'szczepienie', '2022-12-11'),
(23, 23, 12, 'szczepienie', '2022-10-19'),
(24, 24, 11, 'szczepienie', '2022-09-11'),
(25, 25, 6, 'skierowanie', '2022-08-30'),
(26, 3, 5, 'badanie', '2022-10-28'),
(27, 2, 2, 'wizyta wstępna', '2022-10-20'),
(28, 6, 3, 'wizyta wstępna', '2022-12-02'),
(29, 16, 4, 'badanie', '2022-11-20');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `wizyty_dla_określoinych_pacjentow`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `wizyty_dla_określoinych_pacjentow` (
`imie` varchar(40)
,`nazwisko` varchar(50)
,`data_wizyty` date
,`rodzaj` varchar(50)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `wizyty_pacjentów_z_lekiem_na_krążenie`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `wizyty_pacjentów_z_lekiem_na_krążenie` (
`doktor` varchar(50)
,`stanowisko` varchar(60)
,`pacjent` varchar(11)
,`data_wizyty` date
,`lek` varchar(60)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `wyzyty_między`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `wyzyty_między` (
`przyjmujący` varchar(91)
,`stanowisko` varchar(60)
,`numer_wizyty` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `zadrudniony_po_2011_nie_lekarz`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `zadrudniony_po_2011_nie_lekarz` (
`nazwa` varchar(60)
,`imie` varchar(40)
,`nazwisko` varchar(50)
);

-- --------------------------------------------------------

--
-- Struktura widoku `ilosc_lekow_przeznaczenie`
--
DROP TABLE IF EXISTS `ilosc_lekow_przeznaczenie`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ilosc_lekow_przeznaczenie`  AS SELECT count(`l`.`przeznaczenie`) AS `ilosc_lekow`, `l`.`przeznaczenie` AS `przeznaczenie` FROM `leki` AS `l` WHERE `l`.`przeznaczenie` not like 'szczepienie' GROUP BY `l`.`przeznaczenie` HAVING count(`l`.`przeznaczenie`) > 11  ;

-- --------------------------------------------------------

--
-- Struktura widoku `ilosc_sredni_wzrost_k`
--
DROP TABLE IF EXISTS `ilosc_sredni_wzrost_k`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ilosc_sredni_wzrost_k`  AS SELECT count(`pa`.`plec`) AS `kobiety`, avg(`pa`.`wzrost`) AS `sredni_wzrost` FROM `pacjenci` AS `pa` WHERE `pa`.`plec` = 'k''k'  ;

-- --------------------------------------------------------

--
-- Struktura widoku `leki_na_a`
--
DROP TABLE IF EXISTS `leki_na_a`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `leki_na_a`  AS SELECT `leki`.`nazwa` AS `nazwa` FROM `leki` WHERE `leki`.`nazwa` like 'A%''A%'  ;

-- --------------------------------------------------------

--
-- Struktura widoku `najwcześniej_zatrudniony_najstarszy_pracownik`
--
DROP TABLE IF EXISTS `najwcześniej_zatrudniony_najstarszy_pracownik`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `najwcześniej_zatrudniony_najstarszy_pracownik`  AS SELECT max(`pr`.`data_zatrudnienia`) AS `najwcześniej_zatrudniony`, min(`pr`.`data_urodzenia`) AS `najstarszy_pracownik`, `pr`.`imie` AS `imie`, `pr`.`nazwisko` AS `nazwisko`, `s`.`nazwa` AS `stanowisko` FROM (`personel` `pr` join `stanowiska` `s` on(`pr`.`id_stanowisko` = `s`.`id`))  ;

-- --------------------------------------------------------

--
-- Struktura widoku `pacjenci_nazwisko_k`
--
DROP TABLE IF EXISTS `pacjenci_nazwisko_k`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pacjenci_nazwisko_k`  AS SELECT `pa`.`nazwisko` AS `nazwisko`, `pa`.`pesel` AS `pesel`, `pa`.`plec` AS `plec` FROM (`pacjenci` `pa` join `wizyty` `w` on(`pa`.`id` = `w`.`id_pacjent`)) WHERE `pa`.`nazwisko` like 'K%' ORDER BY `pa`.`pesel` AS `DESCdesc` ASC  ;

-- --------------------------------------------------------

--
-- Struktura widoku `personel_wizyty`
--
DROP TABLE IF EXISTS `personel_wizyty`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `personel_wizyty`  AS SELECT `pr`.`imie` AS `imie`, `s`.`nazwa` AS `nazwa`, `w`.`id` AS `id` FROM ((`personel` `pr` left join `stanowiska` `s` on(`pr`.`id_stanowisko` = `s`.`id`)) left join `wizyty` `w` on(`pr`.`id` = `w`.`id_personel`)) WHERE `w`.`id` is nullnull  ;

-- --------------------------------------------------------

--
-- Struktura widoku `przeznaczenie_lekow`
--
DROP TABLE IF EXISTS `przeznaczenie_lekow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `przeznaczenie_lekow`  AS SELECT DISTINCT `leki`.`przeznaczenie` AS `przeznaczenie` FROM `leki``leki`  ;

-- --------------------------------------------------------

--
-- Struktura widoku `recepty_pacjenci`
--
DROP TABLE IF EXISTS `recepty_pacjenci`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `recepty_pacjenci`  AS SELECT concat(`pa`.`imie`,' ',`pa`.`nazwisko`) AS `pacjent`, `pa`.`pesel` AS `pesel`, `r`.`id` AS `id`, `l`.`nazwa` AS `nazwa` FROM (((`pacjenci` `pa` left join `wizyty` `w` on(`pa`.`id` = `w`.`id_pacjent`)) left join `recepty` `r` on(`w`.`id` = `r`.`id_wizta`)) left join `leki` `l` on(`r`.`id_lek` = `l`.`id`)) ORDER BY `r`.`id` DESC LIMIT 0, 1010  ;

-- --------------------------------------------------------

--
-- Struktura widoku `sredni_wzrost_m`
--
DROP TABLE IF EXISTS `sredni_wzrost_m`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sredni_wzrost_m`  AS SELECT count(`pa`.`plec`) AS `mezczyzni`, avg(`pa`.`wzrost`) AS `sredni_wzrost` FROM `pacjenci` AS `pa` WHERE `pa`.`plec` = 'm''m'  ;

-- --------------------------------------------------------

--
-- Struktura widoku `sredni_wzrost_waga_k`
--
DROP TABLE IF EXISTS `sredni_wzrost_waga_k`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sredni_wzrost_waga_k`  AS SELECT avg(`pacjenci`.`wzrost`) AS `sredni_wzrost`, avg(`pacjenci`.`waga`) AS `srednia_waga` FROM `pacjenci` WHERE `pacjenci`.`plec` = 'k''k'  ;

-- --------------------------------------------------------

--
-- Struktura widoku `stanowisko_personel_bez_wizyt`
--
DROP TABLE IF EXISTS `stanowisko_personel_bez_wizyt`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `stanowisko_personel_bez_wizyt`  AS SELECT `pr`.`imie` AS `imie`, `s`.`nazwa` AS `nazwa`, `w`.`id` AS `id` FROM ((`personel` `pr` left join `stanowiska` `s` on(`pr`.`id_stanowisko` = `s`.`id`)) left join `wizyty` `w` on(`pr`.`id` = `w`.`id_personel`)) WHERE `w`.`id` is nullnull  ;

-- --------------------------------------------------------

--
-- Struktura widoku `wizyty_dla_określoinych_pacjentow`
--
DROP TABLE IF EXISTS `wizyty_dla_określoinych_pacjentow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wizyty_dla_określoinych_pacjentow`  AS SELECT `pa`.`imie` AS `imie`, `pa`.`nazwisko` AS `nazwisko`, `w`.`data_wizyty` AS `data_wizyty`, `w`.`rodzaj` AS `rodzaj` FROM (`pacjenci` `pa` left join `wizyty` `w` on(`pa`.`id` = `w`.`id_pacjent`)) WHERE `pa`.`wzrost` > 170 AND `pa`.`waga` > 60 ORDER BY `w`.`data_wizyty` ASC  ;

-- --------------------------------------------------------

--
-- Struktura widoku `wizyty_pacjentów_z_lekiem_na_krążenie`
--
DROP TABLE IF EXISTS `wizyty_pacjentów_z_lekiem_na_krążenie`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wizyty_pacjentów_z_lekiem_na_krążenie`  AS SELECT `pr`.`nazwisko` AS `doktor`, `s`.`nazwa` AS `stanowisko`, `pa`.`pesel` AS `pacjent`, `w`.`data_wizyty` AS `data_wizyty`, `l`.`nazwa` AS `lek` FROM (((((`personel` `pr` join `stanowiska` `s` on(`pr`.`id_stanowisko` = `s`.`id`)) join `wizyty` `w` on(`pr`.`id` = `w`.`id_personel`)) join `recepty` `r` on(`w`.`id` = `r`.`id_wizta`)) join `pacjenci` `pa` on(`w`.`id_pacjent` = `pa`.`id`)) join `leki` `l` on(`r`.`id_lek` = `l`.`id`)) WHERE `l`.`przeznaczenie` = 'krążenie''krążenie'  ;

-- --------------------------------------------------------

--
-- Struktura widoku `wyzyty_między`
--
DROP TABLE IF EXISTS `wyzyty_między`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wyzyty_między`  AS SELECT concat(`pr`.`imie`,' ',`pr`.`nazwisko`) AS `przyjmujący`, `s`.`nazwa` AS `stanowisko`, `w`.`id` AS `numer_wizyty` FROM ((`personel` `pr` join `stanowiska` `s` on(`pr`.`id_stanowisko` = `s`.`id`)) join `wizyty` `w` on(`pr`.`id` = `w`.`id_personel`)) WHERE `w`.`data_wizyty` between '2022-10-01' and '2022-11-25' ORDER BY `w`.`id` ASC  ;

-- --------------------------------------------------------

--
-- Struktura widoku `zadrudniony_po_2011_nie_lekarz`
--
DROP TABLE IF EXISTS `zadrudniony_po_2011_nie_lekarz`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `zadrudniony_po_2011_nie_lekarz`  AS SELECT `s`.`nazwa` AS `nazwa`, `pr`.`imie` AS `imie`, `pr`.`nazwisko` AS `nazwisko` FROM (`personel` `pr` join `stanowiska` `s` on(`pr`.`id_stanowisko` = `s`.`id`)) WHERE year(`pr`.`data_zatrudnienia`) > '2011' AND `s`.`nazwa` <> 'lekarz''lekarz'  ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `leki`
--
ALTER TABLE `leki`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `pacjenci`
--
ALTER TABLE `pacjenci`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `personel`
--
ALTER TABLE `personel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_stanowisko` (`id_stanowisko`);

--
-- Indeksy dla tabeli `recepty`
--
ALTER TABLE `recepty`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_wizta` (`id_wizta`),
  ADD KEY `id_lek` (`id_lek`);

--
-- Indeksy dla tabeli `stanowiska`
--
ALTER TABLE `stanowiska`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `wizyty`
--
ALTER TABLE `wizyty`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pacjent` (`id_pacjent`),
  ADD KEY `id_personel` (`id_personel`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `leki`
--
ALTER TABLE `leki`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT dla tabeli `pacjenci`
--
ALTER TABLE `pacjenci`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT dla tabeli `personel`
--
ALTER TABLE `personel`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT dla tabeli `recepty`
--
ALTER TABLE `recepty`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT dla tabeli `stanowiska`
--
ALTER TABLE `stanowiska`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `wizyty`
--
ALTER TABLE `wizyty`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `personel`
--
ALTER TABLE `personel`
  ADD CONSTRAINT `personel_ibfk_1` FOREIGN KEY (`id_stanowisko`) REFERENCES `stanowiska` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `personel_ibfk_2` FOREIGN KEY (`id_stanowisko`) REFERENCES `stanowiska` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `recepty`
--
ALTER TABLE `recepty`
  ADD CONSTRAINT `recepty_ibfk_1` FOREIGN KEY (`id_lek`) REFERENCES `leki` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `recepty_ibfk_2` FOREIGN KEY (`id_wizta`) REFERENCES `wizyty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `wizyty`
--
ALTER TABLE `wizyty`
  ADD CONSTRAINT `wizyty_ibfk_1` FOREIGN KEY (`id_personel`) REFERENCES `personel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wizyty_ibfk_2` FOREIGN KEY (`id_personel`) REFERENCES `personel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wizyty_ibfk_3` FOREIGN KEY (`id_pacjent`) REFERENCES `pacjenci` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
