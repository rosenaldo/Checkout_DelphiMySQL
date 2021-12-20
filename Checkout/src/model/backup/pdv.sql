-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 27-Out-2021 às 15:45
-- Versão do servidor: 10.4.20-MariaDB
-- versão do PHP: 7.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `pdv`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `caixa`
--

CREATE TABLE `caixa` (
  `id` int(11) NOT NULL,
  `data_abertura` date NOT NULL,
  `hora_abertura` time NOT NULL,
  `valor_abertura` decimal(10,2) NOT NULL,
  `funcionario_abertura` varchar(25) NOT NULL,
  `data_fechamento` date DEFAULT NULL,
  `hora_fechamento` time DEFAULT NULL,
  `valor_fechamento` decimal(10,2) DEFAULT NULL,
  `valor_vendido` decimal(10,2) DEFAULT NULL,
  `valor_quebra` decimal(10,2) DEFAULT NULL,
  `funcionario_fechamento` varchar(25) DEFAULT NULL,
  `num_caixa` int(11) NOT NULL,
  `operador` varchar(25) NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `caixa`
--

INSERT INTO `caixa` (`id`, `data_abertura`, `hora_abertura`, `valor_abertura`, `funcionario_abertura`, `data_fechamento`, `hora_fechamento`, `valor_fechamento`, `valor_vendido`, `valor_quebra`, `funcionario_fechamento`, `num_caixa`, `operador`, `status`) VALUES
(13, '2019-07-04', '16:54:44', '100.00', 'Hugo Freitas', '2019-07-04', '16:56:50', '150.00', '41.00', '9.00', 'Hugo Freitas', 1, 'Marcela Silva', 'Fechado'),
(15, '2019-07-05', '11:21:59', '100.00', 'Hugo Freitas', '2019-07-09', '19:13:07', '60.00', '11.00', '-51.00', 'Hugo Freitas', 1, 'Marcela Silva', 'Fechado'),
(16, '2019-07-05', '16:26:24', '150.00', 'Hugo Freitas', '2019-07-05', '16:28:03', '160.00', '27.00', '-17.00', 'Hugo Freitas', 2, 'Marcela Silva', 'Fechado'),
(17, '2019-07-09', '19:12:27', '50.00', 'Hugo Freitas', '2019-07-09', '19:13:07', '60.00', '11.00', '-51.00', 'Hugo Freitas', 1, 'Marcela Silva', 'Fechado'),
(18, '2019-07-09', '19:21:38', '50.00', 'Hugo Freitas', '2019-07-09', '19:22:00', '60.00', '10.00', '0.00', 'Hugo Freitas', 2, 'Marta', 'Fechado'),
(19, '2019-07-09', '19:38:45', '100.00', 'Hugo Freitas', '2019-07-09', '19:40:08', '125.00', '32.00', '-7.00', 'Hugo Freitas', 3, 'Marcela Silva', 'Fechado'),
(20, '2021-08-01', '15:07:11', '50.00', 'Junior', '2021-08-01', '15:12:28', '20.00', '15.00', '-45.00', 'Junior', 1, 'Micarla', 'Fechado'),
(21, '2021-08-01', '20:11:19', '100.00', 'Junior', '2021-08-01', '20:12:08', '105.00', '10.00', '-5.00', 'Junior', 2, 'Micarla', 'Fechado'),
(22, '2021-09-14', '22:11:09', '5.00', 'v', '2021-09-14', '22:12:17', '5.00', '0.00', '0.00', 'v', 2, 'fasdf', 'Fechado');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cargos`
--

CREATE TABLE `cargos` (
  `id` int(11) NOT NULL,
  `cargo` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `cargos`
--

INSERT INTO `cargos` (`id`, `cargo`) VALUES
(13, 'operador de caixa'),
(14, 'caixa'),
(15, 'gerente');

-- --------------------------------------------------------

--
-- Estrutura da tabela `detalhes_vendas`
--

CREATE TABLE `detalhes_vendas` (
  `id` int(11) NOT NULL,
  `id_venda` int(11) NOT NULL,
  `produto` varchar(25) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `funcionario` varchar(25) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `detalhes_vendas`
--

INSERT INTO `detalhes_vendas` (`id`, `id_venda`, `produto`, `valor`, `quantidade`, `total`, `id_produto`, `funcionario`, `data`) VALUES
(116, 15, 'Coca Cola', '4.50', 5, '22.50', 14, 'Hugo Freitas', '0000-00-00'),
(117, 15, 'Cerveja Lata', '5.00', 3, '15.00', 15, 'Hugo Freitas', '0000-00-00'),
(118, 16, 'Coca Cola', '4.50', 3, '13.50', 14, 'Hugo Freitas', '0000-00-00'),
(119, 17, 'Coca Cola', '4.50', 5, '22.50', 14, 'Hugo Freitas', '0000-00-00'),
(120, 18, 'Suco Natural', '6.00', 2, '12.00', 16, 'Hugo Freitas', '0000-00-00'),
(121, 18, 'Cerveja Lata', '5.00', 3, '15.00', 15, 'Hugo Freitas', '0000-00-00'),
(122, 19, 'Cerveja Lata', '5.00', 3, '15.00', 15, 'Hugo Freitas', '0000-00-00'),
(123, 19, 'Suco Natural', '6.00', 2, '12.00', 16, 'Hugo Freitas', '0000-00-00'),
(124, 20, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(125, 21, 'Cerveja Lata', '5.00', 2, '10.00', 15, 'Hugo Freitas', '0000-00-00'),
(126, 21, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(127, 22, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(128, 22, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(130, 23, 'Cerveja Lata', '5.00', 5, '25.00', 15, 'Hugo Freitas', '0000-00-00'),
(131, 23, 'Suco Natural', '6.00', 10, '60.00', 16, 'Hugo Freitas', '0000-00-00'),
(132, 24, 'Coca Cola', '4.50', 1, '4.50', 14, 'Hugo Freitas', '0000-00-00'),
(133, 24, 'Suco Natural', '6.00', 5, '30.00', 16, 'Hugo Freitas', '0000-00-00'),
(134, 24, 'Cerveja Lata', '5.00', 6, '30.00', 15, 'Hugo Freitas', '0000-00-00'),
(135, 25, 'Suco Natural', '6.00', 5, '30.00', 16, 'Hugo Freitas', '0000-00-00'),
(136, 25, 'Cerveja Lata', '5.00', 4, '20.00', 15, 'Hugo Freitas', '0000-00-00'),
(137, 25, 'Suco Natural', '6.00', 2, '12.00', 16, 'Hugo Freitas', '0000-00-00'),
(138, 25, 'Coca Cola', '4.50', 5, '22.50', 14, 'Hugo Freitas', '0000-00-00'),
(139, 26, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(140, 27, 'Cerveja Lata', '5.00', 5, '25.00', 15, 'Hugo Freitas', '0000-00-00'),
(141, 28, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(142, 29, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(143, 30, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(144, 31, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(145, 32, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(146, 33, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(147, 34, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(148, 35, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(149, 36, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(150, 37, 'Cerveja Lata', '5.00', 6, '30.00', 15, 'Hugo Freitas', '0000-00-00'),
(151, 38, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(152, 39, 'Suco Natural', '6.00', 2, '12.00', 16, 'Hugo Freitas', '0000-00-00'),
(153, 39, 'Cerveja Lata', '5.00', 3, '15.00', 15, 'Hugo Freitas', '0000-00-00'),
(154, 40, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(155, 41, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(156, 41, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(157, 41, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(158, 42, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Marcela Silva', '0000-00-00'),
(159, 43, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Marcela Silva', '0000-00-00'),
(160, 44, 'Cerveja Lata', '5.00', 2, '10.00', 15, 'Marcela Silva', '0000-00-00'),
(161, 44, 'Suco Natural', '6.00', 1, '6.00', 16, 'Marcela Silva', '0000-00-00'),
(162, 45, 'Cerveja Lata', '5.00', 2, '10.00', 15, 'Marcela Silva', '0000-00-00'),
(163, 45, 'Suco Natural', '6.00', 1, '6.00', 16, 'Marcela Silva', '0000-00-00'),
(164, 46, 'Cerveja Lata', '5.00', 2, '10.00', 15, 'Marcela Silva', '0000-00-00'),
(165, 46, 'Suco Natural', '6.00', 1, '6.00', 16, 'Marcela Silva', '0000-00-00'),
(166, 47, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Marta', '0000-00-00'),
(167, 48, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Marcela Silva', '0000-00-00'),
(168, 49, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Marcela Silva', '0000-00-00'),
(169, 49, 'Cerveja Lata', '5.00', 3, '15.00', 15, 'Marcela Silva', '0000-00-00'),
(170, 49, 'Suco Natural', '6.00', 1, '6.00', 16, 'Marcela Silva', '0000-00-00'),
(171, 50, 'Cerveja Lata', '5.00', 4, '20.00', 15, 'Hugo Freitas', '0000-00-00'),
(172, 50, 'Suco Natural', '6.00', 3, '18.00', 16, 'Hugo Freitas', '0000-00-00'),
(173, 50, 'Coca Cola', '4.50', 3, '13.50', 14, 'Hugo Freitas', '0000-00-00'),
(174, 50, 'Coca Cola', '4.50', 2, '9.00', 14, 'Hugo Freitas', '0000-00-00'),
(175, 50, 'Agua Mineral', '3.00', 3, '9.00', 17, 'Hugo Freitas', '0000-00-00'),
(176, 51, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(177, 52, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(178, 53, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(179, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(180, 54, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(181, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(182, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(183, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(184, 54, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(185, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(186, 54, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(187, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(188, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(189, 54, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(190, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(191, 54, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(192, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(193, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(194, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(195, 54, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(196, 54, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(197, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(198, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(199, 54, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(200, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(201, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(202, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(203, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(204, 54, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(205, 54, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(206, 54, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(207, 57, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(208, 57, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(209, 57, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(210, 57, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(211, 57, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(212, 57, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(213, 57, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(214, 57, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(215, 57, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(216, 57, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(217, 57, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(218, 57, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(219, 57, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(220, 57, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(221, 57, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(222, 57, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(223, 57, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(224, 55, 'Cerveja Lata', '5.00', 2, '10.00', 15, 'Marcela Silva', '0000-00-00'),
(225, 56, 'Suco Natural', '6.00', 1, '6.00', 16, 'Marcela Silva', '0000-00-00'),
(226, 56, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Marcela Silva', '0000-00-00'),
(227, 56, 'Suco Natural', '6.00', 1, '6.00', 16, 'Marcela Silva', '0000-00-00'),
(228, 57, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(229, 57, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(230, 57, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(231, 58, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(232, 58, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(233, 59, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(234, 60, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(235, 61, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(236, 61, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(237, 61, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(238, 62, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(239, 62, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(240, 62, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(241, 62, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(242, 62, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(243, 62, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(244, 62, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(245, 62, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(246, 63, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '0000-00-00'),
(247, 63, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '0000-00-00'),
(248, 64, 'Suco Natural', '6.00', 1, '6.00', 16, 'Hugo Freitas', '2019-07-05'),
(249, 64, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '2019-07-05'),
(250, 65, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '2019-07-05'),
(251, 66, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Hugo Freitas', '2019-07-09'),
(252, 67, 'Suco Natural', '6.00', 1, '6.00', 16, 'Marcela Silva', '2019-07-09'),
(253, 67, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Marcela Silva', '2019-07-09'),
(254, 68, 'Cerveja Lata', '5.00', 2, '10.00', 15, 'Hugo Freitas', '2019-07-09'),
(255, 69, 'Cerveja Lata', '5.00', 2, '10.00', 15, 'Marta', '2019-07-09'),
(256, 70, 'Suco Natural', '6.00', 1, '6.00', 16, 'Marcela Silva', '2019-07-09'),
(257, 70, 'Cerveja Lata', '5.00', 3, '15.00', 15, 'Marcela Silva', '2019-07-09'),
(258, 71, 'Coca Cola', '4.50', 1, '4.50', 14, 'Hugo Freitas', '2019-07-09'),
(259, 73, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Micarla', '2021-08-01'),
(260, 73, 'Suco Natural', '6.00', 1, '6.00', 16, 'Micarla', '2021-08-01'),
(261, 74, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Micarla', '2021-08-01'),
(268, 75, 'Cerveja Lata', '5.00', 1, '5.00', 15, 'Micarla', '2021-08-01'),
(273, 76, 'ddd', '3.00', 1, '3.00', 17, 'Administrador', '2021-08-19'),
(278, 78, 'd', '3.00', 1, '3.00', 23, 'Administrador', '2021-09-04'),
(279, 79, 'd', '3.00', 1, '3.00', 23, 'Administrador', '2021-09-04'),
(280, 80, 'd', '3.00', 1, '3.00', 23, 'Administrador', '2021-09-04'),
(281, 81, 'd', '3.00', 1, '3.00', 23, 'Administrador', '2021-09-04'),
(282, 81, 'd', '3.00', 1, '3.00', 23, 'Administrador', '2021-09-04'),
(283, 81, 'd', '3.00', 1, '3.00', 23, 'Administrador', '2021-09-04'),
(284, 81, 'd', '3.00', 1, '3.00', 23, 'Administrador', '2021-09-04'),
(285, 82, 'd', '3.00', 1, '3.00', 23, 'Administrador', '2021-09-04');

-- --------------------------------------------------------

--
-- Estrutura da tabela `empresa`
--

CREATE TABLE `empresa` (
  `id` int(11) NOT NULL,
  `razao_social` varchar(50) NOT NULL,
  `nome_fantasia` varchar(50) NOT NULL,
  `endereco` varchar(100) NOT NULL,
  `bairro` varchar(30) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `uf` char(2) NOT NULL,
  `cnpj` varchar(20) NOT NULL,
  `telefone` varchar(15) NOT NULL,
  `ie` varchar(12) NOT NULL,
  `email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `empresa`
--

INSERT INTO `empresa` (`id`, `razao_social`, `nome_fantasia`, `endereco`, `bairro`, `cidade`, `uf`, `cnpj`, `telefone`, `ie`, `email`) VALUES
(17, '', 'cell e phone', '', '', '', '', '', '', '', ''),
(18, 'f', 'f', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `entrada_produtos`
--

CREATE TABLE `entrada_produtos` (
  `id` int(11) NOT NULL,
  `produto` varchar(25) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `fornecedor` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `data` date NOT NULL,
  `id_produto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `entrada_produtos`
--

INSERT INTO `entrada_produtos` (`id`, `produto`, `quantidade`, `fornecedor`, `valor`, `total`, `data`, `id_produto`) VALUES
(10, 'Agua Mineral', 6, 1, '2.00', '12.00', '2019-06-27', 17),
(11, 'Coca Cola', 20, 1, '3.00', '60.00', '2019-06-26', 14),
(12, 'Suco Natural', 5, 1, '2.00', '10.00', '2019-06-27', 16),
(13, 'Cerveja Lata', 5, 1, '3.00', '15.00', '2019-06-27', 15),
(14, 'Cerveja Lata', 7, 1, '3.00', '21.00', '2019-06-27', 15),
(15, 'Coca Cola', 2, 1, '3.00', '6.00', '2019-06-27', 14),
(16, 'Chocolate', 15, 1, '3.00', '45.00', '2019-06-27', 19),
(17, 'Chocolate', 20, 2, '3.00', '60.00', '2019-07-01', 19),
(18, 'Cerveja Lata', 20, 2, '4.00', '80.00', '2019-07-01', 15),
(19, 'Coca Cola', 50, 1, '3.00', '150.00', '2019-07-02', 14),
(20, 'Cerveja Lata', 60, 1, '4.00', '240.00', '2019-07-02', 15),
(21, 'Cerveja Lata', 100, 1, '3.00', '300.00', '2019-07-02', 15),
(22, 'Suco Natural', 100, 1, '2.00', '200.00', '2019-07-02', 16),
(23, 'Agua Mineral', 10, 1, '3.00', '30.00', '2019-07-05', 17),
(24, 'Cerveja Lata', 5, 1, '3.00', '15.00', '2019-07-09', 15),
(25, 'Agua Mineral', 1, 1, '12.00', '12.00', '2021-08-01', 17),
(30, 'd', 10, 4, '10.00', '100.00', '2021-08-31', 23);

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedores`
--

CREATE TABLE `fornecedores` (
  `id` int(11) NOT NULL,
  `nome` varchar(25) NOT NULL,
  `produto` varchar(25) NOT NULL,
  `endereco` varchar(30) NOT NULL,
  `telefone` varchar(15) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cpf` varchar(20) NOT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `endereco` varchar(50) DEFAULT NULL,
  `cargo` varchar(25) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `gastos`
--

CREATE TABLE `gastos` (
  `id` int(11) NOT NULL,
  `motivo` varchar(25) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `funcionario` varchar(20) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `gastos`
--

INSERT INTO `gastos` (`id`, `motivo`, `valor`, `funcionario`, `data`) VALUES
(6, 'Compra de Materiais', '250.00', 'Hugo Freitas', '2019-07-04'),
(7, 'Compra de Produtos Limpez', '160.00', 'Hugo Freitas', '2019-07-05'),
(8, 'Pagamento', '20.00', 'Hugo Freitas', '2019-07-05'),
(9, 'Compra de Mesa', '65.00', 'Hugo Freitas', '2019-07-09');

-- --------------------------------------------------------

--
-- Estrutura da tabela `movimentacoes`
--

CREATE TABLE `movimentacoes` (
  `id` int(11) NOT NULL,
  `tipo` varchar(10) NOT NULL,
  `movimento` varchar(20) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `funcionario` varchar(20) NOT NULL,
  `data` date NOT NULL,
  `id_movimento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `movimentacoes`
--

INSERT INTO `movimentacoes` (`id`, `tipo`, `movimento`, `valor`, `funcionario`, `data`, `id_movimento`) VALUES
(35, 'Entrada', 'Venda', '5.00', 'Marcela Silva', '2019-07-04', 43),
(36, 'Entrada', 'Venda', '5.00', 'Marcela Silva', '2019-07-04', 43),
(39, 'Entrada', 'Venda', '16.00', 'Marcela Silva', '2019-07-04', 46),
(40, 'Entrada', 'Venda', '5.00', 'Marta', '2019-07-04', 47),
(41, 'Saída', 'Gasto', '250.00', 'Hugo Freitas', '2019-07-04', 6),
(42, 'Entrada', 'Venda', '5.00', 'Marcela Silva', '2019-07-04', 48),
(43, 'Entrada', 'Venda', '20.00', 'Marcela Silva', '2019-07-04', 49),
(44, 'Entrada', 'Venda', '69.50', 'Hugo Freitas', '2019-07-04', 50),
(45, 'Entrada', 'Venda', '5.00', 'Hugo Freitas', '2019-07-04', 51),
(46, 'Entrada', 'Venda', '5.00', 'Hugo Freitas', '2019-07-04', 52),
(47, 'Entrada', 'Venda', '5.00', 'Hugo Freitas', '2019-07-04', 53),
(48, 'Entrada', 'Venda', '6.00', 'Hugo Freitas', '2019-07-04', 54),
(49, 'Entrada', 'Venda', '10.00', 'Marcela Silva', '2019-07-05', 55),
(50, 'Entrada', 'Venda', '17.00', 'Marcela Silva', '2019-07-05', 56),
(51, 'Entrada', 'Venda', '5.00', 'Hugo Freitas', '2019-07-05', 57),
(52, 'Saída', 'Gasto', '160.00', 'Hugo Freitas', '2019-07-05', 7),
(53, 'Saída', 'Gasto', '20.00', 'Hugo Freitas', '2019-07-05', 8),
(54, 'Entrada', 'Venda', '11.00', 'Hugo Freitas', '2019-07-05', 58),
(55, 'Entrada', 'Venda', '6.00', 'Hugo Freitas', '2019-07-05', 59),
(56, 'Entrada', 'Venda', '6.00', 'Hugo Freitas', '2019-07-05', 60),
(57, 'Entrada', 'Venda', '0.00', 'Hugo Freitas', '2019-07-05', 61),
(58, 'Entrada', 'Venda', '0.00', 'Hugo Freitas', '2019-07-05', 62),
(59, 'Entrada', 'Venda', '11.00', 'Hugo Freitas', '2019-07-05', 63),
(60, 'Entrada', 'Venda', '11.00', 'Hugo Freitas', '2019-07-05', 64),
(61, 'Entrada', 'Venda', '5.00', 'Hugo Freitas', '2019-07-05', 65),
(62, 'Entrada', 'Venda', '5.00', 'Hugo Freitas', '2019-07-09', 66),
(63, 'Saída', 'Gasto', '65.00', 'Hugo Freitas', '2019-07-09', 9),
(64, 'Entrada', 'Venda', '11.00', 'Marcela Silva', '2019-07-09', 67),
(66, 'Entrada', 'Venda', '10.00', 'Marta', '2019-07-09', 69),
(67, 'Entrada', 'Venda', '21.00', 'Marcela Silva', '2019-07-09', 70),
(68, 'Entrada', 'Venda', '4.50', 'Hugo Freitas', '2019-07-09', 71),
(69, 'Entrada', 'Venda', '0.00', 'Micarla', '2021-08-01', 72),
(70, 'Entrada', 'Venda', '11.00', 'Micarla', '2021-08-01', 73),
(71, 'Entrada', 'Venda', '4.00', 'Micarla', '2021-08-01', 74),
(72, 'Saída', 'Compra de Produtos', '12.00', 'Administrador', '2021-08-01', 25),
(73, 'Entrada', 'Venda', '-5.00', 'Micarla', '2021-08-01', 75),
(74, 'Entrada', 'Venda', '3.00', 'Administrador', '2021-08-19', 76),
(75, 'Saída', 'Compra de Produtos', '10.00', 'Administrador', '2021-08-22', 26),
(76, 'Saída', 'Compra de Produtos', '1.00', 'Administrador', '2021-08-24', 27),
(77, 'Saída', 'Compra de Produtos', '10.00', 'Administrador', '2021-08-24', 28),
(78, 'Saída', 'Compra de Produtos', '111.00', 'Administrador', '2021-08-24', 29),
(79, 'Saída', 'Compra de Produtos', '100.00', 'Administrador', '2021-08-31', 30),
(80, 'Entrada', 'Venda', '3.00', 'Administrador', '2021-08-31', 77),
(81, 'Entrada', 'Venda', '3.00', 'Administrador', '2021-09-04', 78),
(82, 'Entrada', 'Venda', '3.00', 'Administrador', '2021-09-04', 79),
(83, 'Entrada', 'Venda', '3.00', 'Administrador', '2021-09-04', 80),
(84, 'Entrada', 'Venda', '12.00', 'Administrador', '2021-09-04', 81),
(85, 'Entrada', 'Venda', '3.00', 'Administrador', '2021-09-04', 82),
(86, 'Entrada', 'Venda', '0.00', 'Administrador', '2021-09-04', 83);

-- --------------------------------------------------------

--
-- Estrutura da tabela `os`
--

CREATE TABLE `os` (
  `id` int(11) NOT NULL,
  `cliente` varchar(50) NOT NULL,
  `tecnico` varchar(50) NOT NULL,
  `dtinicial` date NOT NULL,
  `dtfinal` date NOT NULL,
  `status` varchar(45) NOT NULL,
  `garantia` varchar(45) NOT NULL,
  `descricao_servico` text NOT NULL,
  `defeito` text NOT NULL,
  `observacao` text NOT NULL,
  `laudo_tecnico` text NOT NULL,
  `valor_total` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `os`
--

INSERT INTO `os` (`id`, `cliente`, `tecnico`, `dtinicial`, `dtfinal`, `status`, `garantia`, `descricao_servico`, `defeito`, `observacao`, `laudo_tecnico`, `valor_total`) VALUES
(84, 'FSADSADFFSAD', 'DSFSADFSDFDS', '2021-06-16', '2021-06-16', 'Em Andamento', '4', 'FSAD', 'FSDA', 'FSADF', 'SADF', '44'),
(85, 'FSAD', 'SADF', '2021-06-16', '2021-06-16', 'Aberto', '3', 'SADF', 'DFSA', 'SADF', 'SADF', '3');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nome` varchar(25) NOT NULL,
  `descricao` varchar(35) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `estoque` int(11) NOT NULL DEFAULT 0,
  `data` date NOT NULL,
  `imagem` longblob DEFAULT NULL,
  `ultima_compra` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `saida_produtos`
--

CREATE TABLE `saida_produtos` (
  `id` int(11) NOT NULL,
  `produto` varchar(25) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `motivo` varchar(25) NOT NULL,
  `data` date NOT NULL,
  `id_produto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `saida_produtos`
--

INSERT INTO `saida_produtos` (`id`, `produto`, `quantidade`, `motivo`, `data`, `id_produto`) VALUES
(3, 'Coca Cola', 5, 'Roubo', '2019-06-27', 14);

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `usuario` varchar(25) NOT NULL,
  `senha` varchar(25) NOT NULL,
  `cargo` varchar(25) NOT NULL,
  `id_funcionario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `usuario`, `senha`, `cargo`, `id_funcionario`) VALUES
(7, 'Administrador', 'admin', 'admin', 'admin', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `vendas`
--

CREATE TABLE `vendas` (
  `id` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data` date NOT NULL,
  `hora` time NOT NULL,
  `funcionario` varchar(25) NOT NULL,
  `desconto` decimal(10,2) NOT NULL,
  `valor_recebido` decimal(10,2) NOT NULL,
  `troco` decimal(10,2) NOT NULL,
  `status` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `vendas`
--

INSERT INTO `vendas` (`id`, `valor`, `data`, `hora`, `funcionario`, `desconto`, `valor_recebido`, `troco`, `status`) VALUES
(44, '16.00', '2019-07-04', '13:05:51', 'Marcela Silva', '0.00', '20.00', '4.00', 'Cancelada'),
(45, '16.00', '2019-07-04', '13:12:38', 'Marcela Silva', '0.00', '20.00', '4.00', 'Cancelada'),
(46, '16.00', '2019-07-04', '13:20:50', 'Marcela Silva', '0.00', '20.00', '4.00', 'Concluída'),
(47, '5.00', '2019-07-04', '13:36:23', 'Marta', '0.00', '10.00', '5.00', 'Concluída'),
(48, '5.00', '2019-07-04', '16:48:08', 'Marcela Silva', '0.00', '10.00', '5.00', 'Concluída'),
(49, '20.00', '2019-07-04', '16:55:40', 'Marcela Silva', '1.00', '20.00', '0.00', 'Concluída'),
(50, '69.50', '2019-07-04', '18:35:21', 'Hugo Freitas', '0.00', '100.00', '30.50', 'Concluída'),
(51, '5.00', '2019-07-04', '21:42:29', 'Hugo Freitas', '0.00', '50.00', '45.00', 'Concluída'),
(52, '5.00', '2019-07-04', '21:43:07', 'Hugo Freitas', '0.00', '50.00', '45.00', 'Concluída'),
(53, '5.00', '2019-07-04', '21:44:29', 'Hugo Freitas', '0.00', '60.00', '55.00', 'Concluída'),
(54, '6.00', '2019-07-04', '22:29:40', 'Hugo Freitas', '0.00', '20.00', '14.00', 'Concluída'),
(55, '10.00', '2019-07-05', '11:22:24', 'Marcela Silva', '0.00', '10.00', '0.00', 'Concluída'),
(56, '17.00', '2019-07-05', '11:23:18', 'Marcela Silva', '0.00', '20.00', '3.00', 'Concluída'),
(57, '5.00', '2019-07-05', '11:27:45', 'Hugo Freitas', '0.00', '50.00', '45.00', 'Concluída'),
(58, '11.00', '2019-07-05', '15:22:51', 'Hugo Freitas', '0.00', '11.00', '0.00', 'Concluída'),
(59, '6.00', '2019-07-05', '15:23:02', 'Hugo Freitas', '0.00', '10.00', '4.00', 'Concluída'),
(60, '6.00', '2019-07-05', '15:23:13', 'Hugo Freitas', '0.00', '20.00', '14.00', 'Concluída'),
(61, '0.00', '2019-07-05', '16:00:41', 'Hugo Freitas', '0.00', '0.00', '0.00', 'Concluída'),
(62, '0.00', '2019-07-05', '16:13:51', 'Hugo Freitas', '0.00', '0.00', '0.00', 'Concluída'),
(63, '11.00', '2019-07-05', '16:14:09', 'Hugo Freitas', '0.00', '15.00', '4.00', 'Concluída'),
(64, '11.00', '2019-07-05', '20:01:46', 'Hugo Freitas', '0.00', '11.00', '0.00', 'Concluída'),
(65, '5.00', '2019-07-05', '20:38:12', 'Hugo Freitas', '0.00', '5.00', '0.00', 'Concluída'),
(66, '5.00', '2019-07-09', '19:09:36', 'Hugo Freitas', '0.00', '5.00', '0.00', 'Concluída'),
(67, '11.00', '2019-07-09', '19:12:47', 'Marcela Silva', '0.00', '11.00', '0.00', 'Concluída'),
(68, '0.00', '2019-07-09', '19:20:25', 'Hugo Freitas', '0.00', '0.00', '0.00', 'Cancelada'),
(69, '10.00', '2019-07-09', '19:21:51', 'Marta', '0.00', '10.00', '0.00', 'Concluída'),
(70, '21.00', '2019-07-09', '19:39:39', 'Marcela Silva', '0.00', '25.00', '4.00', 'Concluída'),
(71, '4.50', '2019-07-09', '19:46:59', 'Hugo Freitas', '0.00', '4.50', '0.00', 'Concluída'),
(72, '0.00', '2021-08-01', '15:07:40', 'Micarla', '0.00', '0.00', '0.00', 'Concluída'),
(73, '11.00', '2021-08-01', '15:09:04', 'Micarla', '0.00', '20.00', '9.00', 'Concluída'),
(74, '4.00', '2021-08-01', '15:11:04', 'Micarla', '1.00', '5.00', '0.00', 'Concluída'),
(75, '-5.00', '2021-08-01', '20:11:47', 'Micarla', '0.00', '-5.00', '0.00', 'Concluída'),
(76, '3.00', '2021-08-19', '11:17:08', 'Administrador', '0.00', '3.00', '0.00', 'Concluída'),
(77, '3.00', '2021-08-31', '19:31:37', 'Administrador', '0.00', '3.00', '0.00', 'Concluída'),
(78, '3.00', '2021-09-04', '10:35:49', 'Administrador', '0.00', '3.00', '0.00', 'Concluída'),
(79, '3.00', '2021-09-04', '10:37:08', 'Administrador', '0.00', '3.00', '0.00', 'Concluída'),
(80, '3.00', '2021-09-04', '10:38:25', 'Administrador', '0.00', '3.00', '0.00', 'Concluída'),
(81, '12.00', '2021-09-04', '11:05:18', 'Administrador', '0.00', '12.00', '0.00', 'Concluída'),
(82, '3.00', '2021-09-04', '11:07:13', 'Administrador', '0.00', '3.00', '0.00', 'Concluída'),
(83, '0.00', '2021-09-04', '12:20:25', 'Administrador', '0.00', '0.00', '0.00', 'Concluída');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `caixa`
--
ALTER TABLE `caixa`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `cargos`
--
ALTER TABLE `cargos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `detalhes_vendas`
--
ALTER TABLE `detalhes_vendas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `entrada_produtos`
--
ALTER TABLE `entrada_produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `gastos`
--
ALTER TABLE `gastos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `movimentacoes`
--
ALTER TABLE `movimentacoes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `os`
--
ALTER TABLE `os`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `saida_produtos`
--
ALTER TABLE `saida_produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `vendas`
--
ALTER TABLE `vendas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `caixa`
--
ALTER TABLE `caixa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de tabela `cargos`
--
ALTER TABLE `cargos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `detalhes_vendas`
--
ALTER TABLE `detalhes_vendas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=286;

--
-- AUTO_INCREMENT de tabela `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de tabela `entrada_produtos`
--
ALTER TABLE `entrada_produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `gastos`
--
ALTER TABLE `gastos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `movimentacoes`
--
ALTER TABLE `movimentacoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de tabela `os`
--
ALTER TABLE `os`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de tabela `saida_produtos`
--
ALTER TABLE `saida_produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de tabela `vendas`
--
ALTER TABLE `vendas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
