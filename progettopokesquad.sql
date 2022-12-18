-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Creato il: Feb 08, 2019 alle 18:22
-- Versione del server: 10.1.19-MariaDB
-- Versione PHP: 7.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `progettopokesquad`
--

DELIMITER $$
--
-- Procedure
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelezionaPokemonTipo` (`type` VARCHAR(25))  BEGIN
SELECT nome FROM speciepokemon AS s INNER JOIN tipo AS t ON s.Tipo1=t.IdTipo WHERE t.NomeTipo = type;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TipoDebMosse` (`type` SMALLINT)  BEGIN
SELECT nomeMossa FROM mosse as m
WHERE m.TipoMossa = Any (SELECT  e.Attaccante
                        FROM tipo INNER JOIN efficacia as e ON tipo.IdTipo=e.Difensore
                        WHERE e.Difensore=type AND e.Coefficiente>1.0);
END$$

--
-- Funzioni
--
CREATE DEFINER=`root`@`localhost` FUNCTION `MosseTipo` (`tipoM` VARCHAR(25)) RETURNS TINYINT(4) BEGIN 
DECLARE NumMosseTipo tinyint;
SELECT count(*) into NumMosseTipo
FROM mosse as m JOIN apprendimento as a on m.IdMossa = a.IdMossa JOIN tipo AS t ON t.IdTipo = m.TipoMossa
WHERE t.NomeTipo = TipoM;
RETURN NumMosseTipo;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `NaturePok` (`NaturaP` VARCHAR(25)) RETURNS TINYINT(4) BEGIN 
DECLARE NumPk tinyint;
SELECT count(*) into NumPk
FROM natura as n JOIN pokemon as p on n.IdNatura = p.CeNatura 
WHERE n.IdNatura = NaturaP;
RETURN NumPk;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `num_mosse` (`pkm` VARCHAR(15)) RETURNS TINYINT(4) BEGIN 
DECLARE NumMosse tinyint; 
SELECT count(*) into NumMosse 
FROM mosse; RETURN NumMosse; 
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `pokeName` (`pkID` VARCHAR(10)) RETURNS VARCHAR(15) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci BEGIN 
RETURN (SELECT Nome FROM SpeciePokemon AS s WHERE s.ID = pkID); 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `abilita`
--

CREATE TABLE `abilita` (
  `IdAbilita` smallint(6) NOT NULL,
  `NomeAbilita` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DescrAbilita` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Introduzione` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `abilita`
--

INSERT INTO `abilita` (`IdAbilita`, `NomeAbilita`, `DescrAbilita`, `Introduzione`) VALUES
(1, 'Tanfo', 'A volte il cattivo odore emesso dal Pokémon fa tentennare i nemici quando attacca', 3),
(2, 'Piovischio', 'Quando il Pokémon entra in campo, attira la pioggia', 3),
(3, 'Acceleratore', 'La Velocità aumenta a ogni turno', 3),
(4, 'Lottascudo', 'Il Pokémon è protetto da una dura corazza che gli evita di subire brutti colpi', 3),
(5, 'Vigore', 'Se il Pokémon ha tutti i PS, evita che vada KO in un sol colpo. Inoltre, è immune alle mosse che cau', 3),
(6, 'Umidità', 'Aumenta l''umidità circostante, impedendo l''uso di Autodistruzione e di altre mosse esplosive', 3),
(7, 'Scioltezza', 'Il corpo flessibile del Pokémon gli impedisce di subire gli effetti della paralisi', 3),
(8, 'Sabbiavelo', 'L''elusione aumenta durante le tempeste di sabbia', 3),
(9, 'Statico', 'Il contatto fisico con il corpo percorso dall''elettricità statica del Pokémon può causare paralisi', 3),
(10, 'Assorbivolt', 'Se il Pokémon subisce una mossa di tipo Elettro, recupera PS anziché subire danni', 3),
(11, 'Assorbacqua', 'Se il Pokémon subisce una mossa di tipo Acqua, recupera PS anziché subire danni', 3),
(12, 'Indifferenza', 'L''imperturbabilità del Pokémon lo protegge da infatuazioni e provocazioni', 3),
(13, 'Antimeteo', 'Neutralizza gli effetti delle condizioni atmosferiche', 3),
(14, 'Insettocchi', 'La precisione del Pokémon aumenta grazie ai suoi occhi composti', 3),
(15, 'Insonnia', 'Il Pokémon soffre d''insonnia e non può finire addormentato', 3),
(16, 'Cambiacolore', 'Il Pokémon acquisisce il tipo della mossa subita', 3),
(17, 'Immunità', 'L''immunità naturale del Pokémon gli impedisce di essere avvelenato', 3),
(18, 'Fuocardore', 'Se il Pokémon subisce una mossa di tipo Fuoco, ne sfrutta il calore per potenziare le proprie mosse ', 3),
(19, 'Polvoscudo', 'Il Pokémon è protetto da uno strato di scaglie che annulla gli effetti secondari delle mosse subite', 3),
(20, 'Mente Locale', 'Il Pokémon affronta la vita al proprio ritmo e per questo non può essere colpito dalla confusione', 3),
(21, 'Ventose', 'Resiste a strumenti e mosse che causano la sostituzione appiccicandosi al terreno con le ventose', 3),
(22, 'Prepotenza', 'Quando il Pokémon entra in campo, la sua prepotenza intimidisce i nemici, riducendone l''Attacco', 3),
(23, 'Pedinombra', 'Il Pokémon fa un passo sull''ombra del Pokémon avversario per evitare che scappi', 3),
(24, 'Cartavetro', 'Se il Pokémon è colpito da un attacco diretto, grazie alla sua pelle ruvida infligge danni a sua vol', 3),
(25, 'Magidifesa', 'Il suo potere misterioso consente di colpire il Pokémon solo da mosse superefficaci', 3),
(26, 'Levitazione', 'La capacità di levitare senza toccare il suolo conferisce immunità agli attacchi di tipo Terra', 3),
(27, 'Spargispora', 'Può causare avvelenamento, paralisi o sonno a chi manda a segno un attacco diretto', 3),
(28, 'Sincronismo', 'Se un nemico avvelena, paralizza o scotta un Pokémon con questa abilità, viene affetto dallo stesso ', 3),
(29, 'Corpochiaro', 'Rende immuni alla diminuzione delle statistiche causata da abilità o mosse di altri Pokémon', 3),
(30, 'Alternacura', 'Cura i problemi di stato quando il Pokémon viene sostituito', 3),
(31, 'Parafulmine', 'Attira e neutralizza mosse di tipo Elettro e aumenta l''Attacco Speciale', 3),
(32, 'Leggiadro', 'Gli effetti secondari delle mosse sono più probabili', 3),
(33, 'Nuotovelox', 'Se piove, la Velocità aumenta', 3),
(34, 'Clorofilla', 'Se la luce del sole è intensa, la Velocità aumenta', 3),
(35, 'Risplendi', 'llumina tutto intorno, rendendo più probabile incontrare Pokémon selvatici', 3),
(36, 'Traccia', 'Quando il Pokémon entra in campo, copia l''abilità di un nemico', 3),
(37, 'Macroforza', 'L''Attacco del Pokémon raddoppia', 3),
(38, 'Velenopunto', 'Può avvelenare chi manda a segno un attacco diretto', 3),
(39, 'Forza Interiore', 'La capacità di concentrazione del Pokémon evita che tentenni per gli attacchi del nemico', 3),
(40, 'Magmascudo', 'Il Pokémon è protetto da lava incandescente, che gli impedisce di venire congelato', 3),
(41, 'Idrovelo', 'Un velo d''acqua riveste il corpo del Pokémon impedendogli di venire scottato', 3),
(42, 'Magnetismo', 'La carica magnetica attrae i Pokémon di tipo Acciaio impedendone la fuga o la sostituzione', 3),
(43, 'Antisuono', 'Il Pokémon è dotato di una sorta di isolamento acustico che lo rende immune alle mosse basate sul su', 3),
(44, 'Copripioggia', 'Il Pokémon recupera PS quando piove', 3),
(45, 'Sabbiafiume', 'Quando il Pokémon entra in campo, scatena una tempesta di sabbia', 3),
(46, 'Pressione', 'Mette pressione al nemico, facendogli consumare più PP', 3),
(47, 'Grassospesso', 'Il Pokémon è protetto da uno spesso strato di grasso che dimezza il danno causato da mosse di tipo F', 3),
(48, 'Sveglialampo', 'Il Pokémon impiega metà del tempo per risvegliarsi dal sonno rispetto agli altri', 3),
(49, 'Corpodifuoco', 'Al contatto subito, chi sferra l''attacco può venire scottato', 3),
(50, 'Fugafacile', 'Garantisce la fuga dai Pokémon selvatici', 3),
(51, 'Squardofermo', 'La vista acuta del Pokémon impedisce che la sua precisione diminuisca', 3),
(52, 'Ipertaglio', 'L''attacco del Pokémon non può diminuire grazie alla morsa micidiale in cui è in grado di stringere i', 3),
(53, 'Raccolta', 'Il Pokémon a volte trova lo strumento usato da un nemico durante la lotta. Permette di trovare degli', 3),
(54, 'Pigrone', 'Quando il Pokémon usa una mossa, nel turno successivo si riposerà', 3),
(55, 'Tuttafretta', 'Aumenta l''Attacco, ma diminuisce la precisione', 3),
(56, 'Incantevole', 'Può causare infatuazione a chi manda a segno un attacco diretto', 3),
(57, 'Più', 'Aumenta l''Attacco Speciale se ci sono alleati con l''abilità Meno o Più', 3),
(58, 'Meno', 'Aumenta l''Attacco Speciale se ci sono alleati con l''abilità Meno o Più', 3),
(59, 'Previsioni', 'Cambia il tipo del Pokémon in Acqua, Fuoco e Ghiaccio in base alle condizioni atmosferiche', 3),
(60, 'Antifurto', 'Gli strumenti restano appiccicati al corpo adesivo del Pokémon e non possono essere rubati', 3),
(61, 'Muta', 'Il Pokémon può guarire dai problemi di stato facendo la muta completa della pelle', 3),
(62, 'Dentistretti', 'Se è affetto da un problema di stato, il Pokémon tira fuori la grinta e aumenta il proprio Attacco', 3),
(63, 'Pelledura', 'Le meravigliose scaglie del Pokémon aumentano la Difesa se esso ha problemi di stato', 3),
(64, 'Melma', 'Il Pokémon secerne delle sostanze tossiche. Se un nemico manda a segno una mossa che assorbe i PS, s', 3),
(65, 'Erbaiuto', 'Quando il Pokémon ha pochi PS, la potenza delle sue mosse di tipo Erba aumenta', 3),
(66, 'Aiutofuoco', 'Quando il Pokémon ha pochi PS, la potenza delle sue mosse di tipo Fuoco aumenta', 3),
(67, 'Acquaiuto', 'Quando il Pokémon ha pochi PS, la potenza delle sue mosse di tipo Acqua aumenta', 3),
(68, 'Aiutinsetto', 'Quando il Pokémon ha pochi PS, la potenze delle sue mosse di tipo Coleottero aumenta', 3),
(69, 'Testadura', 'Protegge il Pokémon dai contraccolpi', 3),
(70, 'Siccità', 'Il sole brilla intensamente quando il Pokémon entra in campo', 3),
(71, 'Trappoarena', 'Impedisce la fuga al nemico', 3),
(72, 'Spiritovivo', 'Il Pokémon è talmente vivace che non può addormentarsi', 3),
(73, 'Fumochiaro', 'Il Pokémon è protetto da un fumo chiaro che impedisce ai nemici di diminuire le sue statistiche', 3),
(74, 'Forzapura', 'Usando la sua Forzapura, il Pokémon raddoppia il suo Attacco', 3),
(75, 'Guscioscudo', 'Il Pokémon è protetto da un guscio robusto che gli evita di subire brutti colpi', 3),
(76, 'Riparo', 'Neutralizza gli effetti delle condizioni atmosferiche', 3),
(77, 'Intricopiedi', 'Se il Pokémon è confuso, ne aumenta l''elusione', 4),
(78, 'Elettrorapid', 'Se il Pokémon viene colpito da una mossa di tipo Elettro, la neutralizza e sfrutta la carica elettri', 4),
(79, 'Antagonismo', 'Rende più competitivi e aumenta il danno contro i Pokémon dello stesso sesso, ma infligge meno danni', 4),
(80, 'Cuordeciso', 'Se il Pokémon tentenna, il suo animo indomito si risveglia e la sua Velocità aumenta', 4),
(81, 'Mantelneve', 'Aumenta l''elusione quando grandina', 4),
(82, 'Voracità', 'Il Pokémon non attende di aver perso molti PS per mangiare certe bacche, ma lo fa non appena i suoi ', 4),
(83, 'Grancollera', 'Se il Pokémon subisce un brutto colpo, monta su tutte le furie e il suo Attacco aumenta al massimo', 4),
(84, 'Agiltecnica', 'Aumenta la Velocità dopo aver usato o perso uno strumento', 4),
(85, 'Antifuoco', 'Il corpo resistente al calore del Pokémon dimezza il danno delle mosse di tipo Fuoco che subisce', 4),
(86, 'Disinvoltura', 'I cambi di statistiche che il Pokémon riceve sono raddoppiate', 4),
(87, 'Pellearsa', 'Il Pokémon recupera PS se piove o se subisce mosse di tipo Acqua, ma con la luce solare intensa perd', 4),
(88, 'Download', 'Analizza Difesa e Difesa Speciale dal nemico e, a seconda di qual è la più bassa, aumenta il proprio', 4),
(89, 'Ferropugno', 'Potenzia le mosse che utilizzano pugni', 4),
(90, 'Velencura', 'Ridà PS se il Pokémon è avvelenato, invece di perdere PS', 4),
(91, 'Adattabilità', 'Potenzia le mosse dello stesso tipo del Pokémon', 4),
(92, 'Abillegame', 'Le mosse multicolpo eseguono sempre il massimo degli attacchi possibili', 4),
(93, 'Idratazione', 'Se piove, il Pokémon guarisce dai problemi di stato', 4),
(94, 'Solarpotere', 'Se c''è il sole aumenta l''Attacco Speciale, ma i PS diminuiscono ad ogni turno', 4),
(95, 'Piedisvelti', 'Aumenta la Velocità se c''è un problema di stato', 4),
(96, 'Normalità', 'Le mosse del Pokémon diventano di tipo Normale. La potenza di queste mosse è aumentata di poco', 4),
(97, 'Cecchino', 'Aumenta i danni inflitti dai brutti colpi quando si attacca', 4),
(98, 'Magicscudo', 'Il Pokémon subisce danni solo dagli attacchi', 4),
(99, 'Nullodifesa', 'Il Pokémon e chiunque lo attacchi abbassano la guardia e le loro mosse vanno sempre a segno', 4),
(100, 'Rallentatore', 'Il Pokémon agisce sempre per ultimo', 4),
(101, 'Tecnico', 'Potenzia le mosse più deboli del Pokémon', 4),
(102, 'Fogliamanto', 'Se la luce del sole è intensa, evita i problemi di stato', 4),
(103, 'Impaccio', 'Il Pokémon non può usare lo strumento che ha', 4),
(104, 'Rompiforma', 'Quando il Pokémon attacca, ignora l''abilità del bersaglio se questa ha effetto sulle mosse', 4),
(105, 'Supersorte', 'Il Pokémon ha una fortuna incredibile che aumenta la sua probabilità di infliggere brutti colpi', 4),
(106, 'Scoppio', 'Arreca danni all''attaccante se attacca il Pokémon con il colpo finale', 4),
(107, 'Presagio', 'Rivela se il nemico ha mosse pericolose', 4),
(108, 'Premonizione', 'Quando il Pokémon entra in campo, rivela la mossa più forte del nemico', 4),
(109, 'Imprudenza', 'Quando il Pokémon attacca, ignora le modifiche alle statistiche del nemico', 4),
(110, 'Lentifumè', 'Il Pokémon può usare le mosse non molto efficaci per arrecare danno normale', 4),
(111, 'Filtro', 'Riduce la potenza delle mosse superefficaci subite', 4),
(112, 'Lentoinizio', 'Per cinque turni, l''Attacco e la Velocità del Pokémon sono dimezzati', 4),
(113, 'Nervisaldi', 'Permette di colpire Pokémon di tipo Spettro con mosse di tipo Normale e Lotta', 4),
(114, 'Acquascolo', 'Attira e neutralizza mosse di tipo Acqua e aumenta l''Attacco Speciale', 4),
(115, 'Corpogelo', 'Quando grandina, il Pokémon recupera PS', 4),
(116, 'Solidroccia', 'Riduce la potenza delle mosse superefficaci subite', 4),
(117, 'Scendineve', 'Il Pokémon provoca una grandinata durante la lotta', 4),
(118, 'Mielincetta', 'Il Pokémon può raccogliere del Miele alla fine della lotta', 4),
(119, 'Indagine', 'Quando il Pokémon entra in campo, rivela lo strumento del nemico', 4),
(120, 'Temerarietà', 'Potenzia le mosse che provocano contraccolpi', 4),
(121, 'Multitipo', 'Cambia il tipo del Pokémon a seconda della Lastra o Cristallo Z che ha', 4),
(122, 'Regalfiore', 'Aumenta l''Attacco e la Difesa Speciale a se stesso e agli alleati con luce solare intensa', 4),
(123, 'Sogniamari', 'Riduce i PS dei nemici addormentati', 4),
(124, 'Arraffalesto', 'Al contatto subito, ruba lo strumento di chi lo ha attaccato', 5),
(125, 'Forzabruta', 'Aumenta i danni delle mosse, ma ne annulla gli effetti aggiuntivi', 5),
(126, 'Inversione', 'Le modifiche alle statistiche hanno effetto inverso', 5),
(127, 'Agitazione', 'Il nemico viene intimidito e non può mangiare Bacche', 5),
(128, 'Agonismo', 'L''Attacco aumenta di molto quando un nemico fa calare le statistiche', 5),
(129, 'Sconforto', 'Quando i PS scendono a metà o meno, il Pokémon si scoraggia e l''Attacco e l''Attacco Speciale vengono', 5),
(130, 'Corpofunesto', 'A volte inibisce l''ultima mossa usata dal nemico', 5),
(131, 'Curacuore', 'A volte cura i problemi di stato degli alleati', 5),
(132, 'Amicoscudo', 'Riduce il danno subìto dagli alleati', 5),
(133, 'Sollguscio', 'Se si subiscono danni da mosse fisiche, la Difesa diminuisce e la Velocità aumenta di molto', 5),
(134, 'Metalpesante', 'Raddoppia il peso del Pokémon', 5),
(135, 'Metalleggero', 'Dimezza il peso del Pokémon', 5),
(136, 'Multisquame', 'Riduce la quantità di danno subìto se i PS sono al massimo', 5),
(137, 'Velenimpeto', 'Aumenta l''Attacco se il Pokémon è avvelenato', 5),
(138, 'Bruciaimpeto', 'Aumenta l''Attacco Speciale se il Pokémon è scottato', 5),
(139, 'Coglibacche', 'Può ricreare una bacca utilizzata', 5),
(140, 'Telepatia', 'Prevede ed evita gli attacchi degli alleati', 5),
(141, 'Altalena', 'Aumenta di molto una statistica e ne riduce un''altra ad ogni turno', 5),
(142, 'Copricapo', 'Protegge il Pokémon da polvere, sabbia e grandine', 5),
(143, 'Velentocco', 'Può avvelenare il nemico al solo contatto', 5),
(144, 'Rigenergia', 'Il Pokémon recupera un po'' di PS quando viene sostituito', 5),
(145, 'Pettinfuori', 'Evita che la Difesa diminuisca', 5),
(146, 'Remasabbia', 'La Velocità aumenta durante le tempeste di sabbia', 5),
(147, 'Splendicute', 'Resiste più facilmente ai cambiamenti di stato', 5),
(148, 'Ponderazione', 'Se agisce per ultimo, la potenza della mossa sale', 5),
(149, 'Illusione', 'Entra con le sembianze dell''ultimo Pokémon in squadra', 5),
(150, 'Sosia', 'Si trasforma nel Pokémon che ha davanti', 5),
(151, 'Intrapasso', 'Attacca evitando le barriere e il sostituto del nemico', 5),
(152, 'Mummia', 'Il contatto con il Pokémon cambia l''abilità dell''attaccante in Mummia', 5),
(153, 'Arroganza', 'Il Pokémon mostra Arroganza e questo aumenta l''Attacco quando manda un nemico KO', 5),
(154, 'Giustizia', 'Subendo una mossa di tipo Buio aumenta l''Attacco del Pokémon, per giustizia', 5),
(155, 'Paura', 'Mosse Buio, Spettro e Coleottero impauriscono il Pokémon e aumentano la sua Velocità', 5),
(156, 'Magispecchio', 'Riflette al mittente le mosse di stato invece di subirle', 5),
(157, 'Mangiaerba', 'Se il Pokémon viene colpito da una mossa di tipo Erba, la neutralizza e aumenta l''Attacco', 5),
(158, 'Burla', 'Le mosse di stato del Pokémon acquistano priorità alta', 5),
(159, 'Silicoforza', 'Potenzia le mosse di tipo Roccia, Terra e Acciaio nelle tempeste di sabbia', 5),
(160, 'Spineferrate', 'Se chi attacca mette a segno una mossa fisica, viene danneggiato dalle spine ferrate', 5),
(161, 'Stato Zen', 'Se il Pokémon è in difficoltà, ne cambia l''aspetto', 5),
(162, 'Vittorstella', 'Aumenta la precisione di chi la possiede e quella degli alleati', 5),
(163, 'Piroturbina', 'Neutralizza le abilità che bloccano le mosse', 5),
(164, 'Teravolt', 'Neutralizza le abilità che bloccano le mosse', 5),
(165, 'Aromavelo', 'Protegge tutta la squadra da mosse che limitano la scelta di attacchi', 6),
(166, 'Fiorvelo', 'Evita il calo delle statistiche degli alleati di tipo Erba e li protegge dai problemi di stato', 6),
(167, 'Guancegonfie', 'Fa recuperare PS quando il Pokémon mangia una bacca', 6),
(168, 'Mutatipo', 'Cambia il tipo del Pokémon in quello della mossa usata', 6),
(169, 'Foltopelo', 'Dimezza il danno degli attacchi fisici subiti', 6),
(170, 'Prestigiatore', 'Ruba lo strumento del Pokémon su cui è stata usata una mossa', 6),
(171, 'Antiproiettile', 'Protegge da alcune mosse a base di proiettili e bombe', 6),
(172, 'Tenacia', 'L''Attacco Speciale aumenta di molto quando le statistiche diminuiscono a causa di un nemico', 6),
(173, 'Ferromascella', 'La robusta mascella del Pokémon permette morsi molto potenti', 6),
(174, 'Pellegelo', 'Le mosse di tipo Normale diventano di tipo Ghiaccio e la loro potenza aumenta un po''', 6),
(175, 'Dolcevelo', 'Impedisce a sé e agli alleati di addormentarsi', 6),
(176, 'Accendilotta', 'Assume la Forma Spada se usa una mossa d''attacco e la Forma Scudo se usa Scudo Reale', 6),
(177, 'Aliraffica', 'Se il Pokémon ha tutti i PS, le sue mosse di tipo Volante acquistano priorità alta', 6),
(178, 'Megalancio', 'Potenzia le mosse "pulsar", Forzasfera e Ondasana', 6),
(179, 'Peloderba', 'Aumenta la Difesa del Pokémon durante l''effetto di Campo Erboso', 6),
(180, 'Simbiosi', 'Il Pokémon può passare il suo strumento a un alleato che ha già usato uno strumento', 6),
(181, 'Unghiedure', 'Potenzia le mosse che causano un contatto fisico', 6),
(182, 'Pellefolletto', 'Le mosse di tipo Normale diventano di tipo Folletto. La potenza di queste mosse aumenta un po''', 6),
(183, 'Viscosità', 'Riduce la Velocità del Pokémon con cui entra in contatto', 6),
(184, 'Pellecielo', 'Le mosse di tipo Normale diventano di tipo Volante. La potenza di queste mosse aumenta un po''', 6),
(185, 'Amorefiliale', 'Il Pokémon e il suo piccolo attaccano ciascuno', 6),
(186, 'Auratetra', 'Potenzia le mosse di tipo Buio di tutti i Pokémon', 6),
(187, 'Aurafolletto', 'Potenzia le mosse di tipo Folletto di tutti i Pokémon', 6),
(188, 'Frangiaura', 'Inverte gli effetti di tutte le aure riducendone la potenza', 6),
(189, 'Mare Primordiale', 'Il Pokémon cambia il tempo per rendere inefficaci gli attacchi di tipo Fuoco', 6),
(190, 'Terra Estrema', 'Il Pokémon cambia il tempo per rendere inefficaci gli attacchi di tipo Acqua', 6),
(191, 'Flusso Delta', 'Il Pokémon cambia il clima per annullare tutti i punti deboli del tipo Volante', 6),
(192, 'Sopportazione', 'Se il Pokémon subisce un attacco, la sua Difesa aumenta', 7),
(193, 'Fuggifuggi', 'Se i PS scendono a metà o meno, il Pokémon si fa prendere dalla paura e abbandona la lotta in tutta ', 7),
(194, 'Passoindietro', 'Se i PS scendono a metà o meno, il Pokémon abbandona la lotta per sfuggire al pericolo', 7),
(195, 'Idrorinforzo', 'Se il Pokémon subisce una mossa di tipo Acqua, la sua Difesa aumenta di molto', 7),
(196, 'Spietatezza', 'Gli attacchi sferrati su un bersaglio avvelenato producono sempre brutti colpi', 7),
(197, 'Scudosoglia', 'Se i PS scendono a metà o meno, il guscio si rompe e il Pokémon si prepara all''offensiva', 6),
(198, 'Sorveglianza', 'Raddoppia i danni inflitti a un bersaglio che è appena entrato in campo per sostituire un altro Poké', 7),
(199, 'Bolladacqua', 'Riduce la potenza delle mosse di tipo Fuoco subite e rende immuni alle scottature', 7),
(200, 'Tempracciaio', 'Aumenta la potenza delle mosse di tipo Acciaio', 7),
(201, 'Furore', 'Se i PS scendono a metà o meno a causa di un attacco, l''Attacco Speciale aumenta', 7),
(202, 'Spalaneve', 'Se grandina, la Velocità aumenta', 7),
(203, 'Distacco', 'Il Pokémon è in grado di usare tutte le sue mosse senza entrare in contatto diretto con il bersaglio', 6),
(204, 'Idrovoce', 'Le mosse basate sul suono del Pokémon con questa abilità diventano di tipo Acqua', 7),
(205, 'Primacura', 'Le mosse che ripristinano direttamente i PS del Pokémon acquistano priorità alta', 7),
(206, 'Pellelettro', 'Le mosse di tipo Normale diventano di tipo Elettro e la loro potenza aumenta un po''', 7),
(207, 'Codasurf', 'In presenza di un Campo Elettrico, la Velocità raddoppia', 7),
(208, 'Banco', 'Quando ha molti PS, il Pokémon forma un banco con i propri simili e si rafforza. Quando ne ha pochi,', 7),
(209, 'Fantasmanto', 'Il panno che ricopre il Pokémon lo protegge da un singolo attacco', 6),
(210, 'Morfosintonia', 'Se il Pokémon manda KO un nemico, il legame con l''Allenatore si rafforza, attivando la trasformazion', 7),
(211, 'Sciamefusione', 'Se i PS del Pokémon scendono a metà o meno, le cellule si raggruppano e gli permettono di assumere l', 7),
(212, 'Corrosione', 'Il Pokémon è in grado di avvelenare il bersaglio anche se questo è di tipo Acciaio o Veleno', 7),
(213, 'Sonno Assoluto', 'Il Pokémon si trova in un costante stato di dormiveglia che gli impedisce di svegliarsi. Può attacca', 7),
(214, 'Regalità', 'L''aura di regalità del Pokémon impedisce al nemico di attaccarlo con mosse che hanno priorità alta', 7),
(215, 'Espellinterno', 'Se il Pokémon viene mandato KO da un attacco, infligge a chi lo ha sferrato tanti danni quanti erano', 6),
(216, 'Sincrodanza', 'Permette al Pokémon di copiare immediatamente qualsiasi mossa basata sulla danza usata da un altro P', 7),
(217, 'Batteria', 'Aumenta la potenza delle mosse speciali degli alleati', 7),
(218, 'Morbidone', 'Dimezza il danno causato dagli attacchi diretti di un nemico, ma raddoppia quello subito dalle mosse', 7),
(219, 'Corposgargiante', 'Il Pokémon sbalordisce il nemico e non gli permette di attaccarlo con mosse che hanno priorità alta', 7),
(220, 'Cuoreanima', 'Aumenta l’Attacco Speciale ogni volta che un Pokémon va KO', 7),
(221, 'Boccolidoro', 'Se il Pokémon viene colpito da un attacco diretto, la Velocità di chi l''ha colpito diminuisce', 6),
(222, 'Ricezione', 'Il Pokémon acquisisce l''abilità di un alleato andato KO', 7),
(223, 'Forza Chimica', 'Il Pokémon trasforma la propria abilità in quella di un alleato andato KO', 7),
(224, 'Ultraboost', 'Se il Pokémon ha mandato KO almeno un altro Pokémon nel turno, aumenta la propria statistica di punt', 7),
(225, 'Sistema Primevo', 'Il tipo del Pokémon cambia in base alla ROM installata', 7),
(226, 'Elettrogenesi', 'Quando il Pokémon entra in campo, lo trasforma in un Campo Elettrico', 7),
(227, 'Psicogenesi', 'Quando il Pokémon entra in campo, lo trasforma in un Campo Psichico', 6),
(228, 'Nebbiogenesi', 'Quando il Pokémon entra in campo, lo trasforma in un Campo Nebbioso', 7),
(229, 'Erbogenesi', 'Quando il Pokémon entra in campo, lo trasforma in un Campo Erboso', 7),
(230, 'Metalprotezione', 'Rende immuni alla diminuzione delle statistiche causata da abilità o mosse di altri Pokémon', 7),
(231, 'Spettroguardia', 'Se i PS sono al massimo, riduce il danno subito', 7),
(232, 'Scudoprisma', 'Riduce la potenza delle mosse superefficaci subite', 7),
(233, 'Cerebroforza', 'Potenzia le mosse superefficaci', 7);

-- --------------------------------------------------------

--
-- Struttura della tabella `apprendimento`
--

CREATE TABLE `apprendimento` (
  `IdMossa` smallint(6) NOT NULL,
  `IdSPokemon` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `apprendimento`
--

INSERT INTO `apprendimento` (`IdMossa`, `IdSPokemon`) VALUES
(10, '#004'),
(10, '#005'),
(10, '#006'),
(10, '#055'),
(17, '#006'),
(22, '#001'),
(22, '#002'),
(22, '#003'),
(33, '#001'),
(33, '#002'),
(33, '#003'),
(33, '#007'),
(33, '#008'),
(33, '#009'),
(33, '#010'),
(36, '#001'),
(36, '#002'),
(36, '#003'),
(38, '#001'),
(38, '#002'),
(38, '#003'),
(39, '#007'),
(39, '#008'),
(39, '#009'),
(39, '#055'),
(44, '#007'),
(44, '#008'),
(44, '#009'),
(45, '#001'),
(45, '#002'),
(45, '#003'),
(45, '#004'),
(45, '#005'),
(45, '#006'),
(50, '#055'),
(52, '#004'),
(52, '#005'),
(52, '#006'),
(53, '#004'),
(53, '#005'),
(53, '#006'),
(55, '#007'),
(55, '#008'),
(55, '#009'),
(55, '#055'),
(56, '#007'),
(56, '#008'),
(56, '#009'),
(56, '#055'),
(73, '#001'),
(73, '#002'),
(73, '#003'),
(74, '#001'),
(74, '#002'),
(74, '#003'),
(75, '#001'),
(75, '#002'),
(75, '#003'),
(76, '#002'),
(76, '#003'),
(77, '#001'),
(77, '#002'),
(77, '#003'),
(79, '#001'),
(79, '#002'),
(79, '#003'),
(80, '#003'),
(81, '#010'),
(82, '#004'),
(82, '#005'),
(82, '#006'),
(83, '#004'),
(83, '#005'),
(83, '#006'),
(90, '#009'),
(93, '#055'),
(103, '#055'),
(106, '#011'),
(108, '#004'),
(108, '#005'),
(108, '#006'),
(110, '#007'),
(110, '#008'),
(110, '#009'),
(130, '#007'),
(130, '#008'),
(130, '#009'),
(133, '#055'),
(145, '#007'),
(145, '#008'),
(145, '#009'),
(154, '#055'),
(163, '#004'),
(163, '#005'),
(163, '#006'),
(182, '#007'),
(182, '#008'),
(182, '#009'),
(184, '#004'),
(184, '#005'),
(184, '#006'),
(229, '#007'),
(229, '#008'),
(229, '#009'),
(230, '#001'),
(230, '#002'),
(230, '#003'),
(235, '#001'),
(235, '#002'),
(235, '#003'),
(240, '#007'),
(240, '#008'),
(240, '#009'),
(244, '#055'),
(257, '#006'),
(334, '#007'),
(334, '#008'),
(334, '#009'),
(337, '#006'),
(346, '#055'),
(352, '#007'),
(352, '#008'),
(352, '#009'),
(352, '#055'),
(382, '#055'),
(388, '#001'),
(388, '#002'),
(388, '#003'),
(394, '#006'),
(401, '#007'),
(401, '#008'),
(401, '#055'),
(402, '#001'),
(403, '#006'),
(421, '#006'),
(424, '#004'),
(424, '#005'),
(424, '#006'),
(428, '#055'),
(430, '#009'),
(450, '#010'),
(453, '#055'),
(472, '#055'),
(481, '#004'),
(481, '#005'),
(481, '#006'),
(487, '#055'),
(517, '#004'),
(517, '#005'),
(517, '#006'),
(572, '#003');

-- --------------------------------------------------------

--
-- Struttura della tabella `composizione`
--

CREATE TABLE `composizione` (
  `Squadra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `NickPokemon` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `composizione`
--

INSERT INTO `composizione` (`Squadra`, `NickPokemon`) VALUES
('Squadra1', 'Ariados1'),
('Squadra1', 'Cacturne1'),
('Squadra1', 'Charizard1'),
('Squadra1', 'Golduck1'),
('Squadra1', 'Golem1'),
('Squadra1', 'Rhyhorn1'),
('Squadra2', 'Charizard1'),
('Squadra2', 'Ho-Oh1'),
('Squadra2', 'Ludicolo1'),
('Squadra2', 'Mew1'),
('Squadra2', 'Scyther1'),
('Squadra2', 'Shuppet1'),
('Squadra3', 'Groudon1'),
('Squadra3', 'Ho-Oh1'),
('Squadra3', 'Kingler1'),
('Squadra3', 'Kyogre3'),
('Squadra3', 'Rayquaza1'),
('Squadra3', 'Sceptile1'),
('Squadra4', 'Ariados1'),
('Squadra4', 'Golem1'),
('Squadra4', 'Kyogre2'),
('Squadra4', 'Ludicolo1'),
('Squadra4', 'Rayquaza2'),
('Squadra4', 'Scyther1');

-- --------------------------------------------------------

--
-- Struttura della tabella `conoscenza`
--

CREATE TABLE `conoscenza` (
  `CeNickname` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IdMossa` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `conoscenza`
--

INSERT INTO `conoscenza` (`CeNickname`, `IdMossa`) VALUES
('Charizard1', 108),
('Charizard1', 163),
('Charizard1', 424),
('Charizard1', 517),
('Golduck1', 93),
('Golduck1', 103),
('Golduck1', 352),
('Golduck1', 472);

-- --------------------------------------------------------

--
-- Struttura della tabella `efficacia`
--

CREATE TABLE `efficacia` (
  `Attaccante` smallint(6) NOT NULL,
  `Difensore` smallint(6) NOT NULL,
  `Coefficiente` decimal(2,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `efficacia`
--

INSERT INTO `efficacia` (`Attaccante`, `Difensore`, `Coefficiente`) VALUES
(0, 0, '1.0'),
(0, 1, '1.0'),
(0, 2, '1.0'),
(0, 3, '1.0'),
(0, 4, '1.0'),
(0, 5, '1.0'),
(0, 6, '1.0'),
(0, 7, '1.0'),
(0, 8, '1.0'),
(0, 9, '1.0'),
(0, 10, '0.5'),
(0, 11, '1.0'),
(0, 12, '1.0'),
(0, 13, '1.0'),
(0, 14, '0.0'),
(0, 15, '1.0'),
(0, 16, '0.5'),
(0, 17, '1.0'),
(1, 0, '1.0'),
(1, 1, '0.5'),
(1, 2, '1.0'),
(1, 3, '0.5'),
(1, 4, '1.0'),
(1, 5, '2.0'),
(1, 6, '1.0'),
(1, 7, '1.0'),
(1, 8, '1.0'),
(1, 9, '1.0'),
(1, 10, '0.5'),
(1, 11, '2.0'),
(1, 12, '2.0'),
(1, 13, '0.5'),
(1, 14, '1.0'),
(1, 15, '1.0'),
(1, 16, '2.0'),
(1, 17, '1.0'),
(2, 0, '2.0'),
(2, 1, '1.0'),
(2, 2, '1.0'),
(2, 3, '1.0'),
(2, 4, '0.5'),
(2, 5, '1.0'),
(2, 6, '0.5'),
(2, 7, '1.0'),
(2, 8, '1.0'),
(2, 9, '0.5'),
(2, 10, '2.0'),
(2, 11, '2.0'),
(2, 12, '0.5'),
(2, 13, '1.0'),
(2, 14, '0.0'),
(2, 15, '2.0'),
(2, 16, '2.0'),
(2, 17, '0.5'),
(3, 0, '1.0'),
(3, 1, '2.0'),
(3, 2, '1.0'),
(3, 3, '0.5'),
(3, 4, '1.0'),
(3, 5, '0.5'),
(3, 6, '1.0'),
(3, 7, '1.0'),
(3, 8, '2.0'),
(3, 9, '1.0'),
(3, 10, '2.0'),
(3, 11, '1.0'),
(3, 12, '1.0'),
(3, 13, '0.5'),
(3, 14, '1.0'),
(3, 15, '1.0'),
(3, 16, '1.0'),
(3, 17, '1.0'),
(4, 0, '1.0'),
(4, 1, '1.0'),
(4, 2, '2.0'),
(4, 3, '1.0'),
(4, 4, '1.0'),
(4, 5, '2.0'),
(4, 6, '1.0'),
(4, 7, '0.5'),
(4, 8, '1.0'),
(4, 9, '1.0'),
(4, 10, '0.5'),
(4, 11, '1.0'),
(4, 12, '2.0'),
(4, 13, '1.0'),
(4, 14, '1.0'),
(4, 15, '1.0'),
(4, 16, '0.5'),
(4, 17, '1.0'),
(5, 0, '1.0'),
(5, 1, '0.5'),
(5, 2, '1.0'),
(5, 3, '2.0'),
(5, 4, '0.5'),
(5, 5, '0.5'),
(5, 6, '0.5'),
(5, 7, '1.0'),
(5, 8, '2.0'),
(5, 9, '1.0'),
(5, 10, '2.0'),
(5, 11, '1.0'),
(5, 12, '0.5'),
(5, 13, '0.5'),
(5, 14, '1.0'),
(5, 15, '1.0'),
(5, 16, '0.5'),
(5, 17, '1.0'),
(6, 0, '1.0'),
(6, 1, '1.0'),
(6, 2, '1.0'),
(6, 3, '1.0'),
(6, 4, '1.0'),
(6, 5, '2.0'),
(6, 6, '0.5'),
(6, 7, '1.0'),
(6, 8, '0.5'),
(6, 9, '1.0'),
(6, 10, '0.5'),
(6, 11, '1.0'),
(6, 12, '1.0'),
(6, 13, '1.0'),
(6, 14, '0.5'),
(6, 15, '1.0'),
(6, 16, '0.0'),
(6, 17, '2.0'),
(7, 0, '1.0'),
(7, 1, '1.0'),
(7, 2, '1.0'),
(7, 3, '2.0'),
(7, 4, '2.0'),
(7, 5, '0.5'),
(7, 6, '1.0'),
(7, 7, '0.5'),
(7, 8, '0.0'),
(7, 9, '1.0'),
(7, 10, '1.0'),
(7, 11, '1.0'),
(7, 12, '1.0'),
(7, 13, '0.5'),
(7, 14, '1.0'),
(7, 15, '1.0'),
(7, 16, '1.0'),
(7, 17, '1.0'),
(8, 0, '1.0'),
(8, 1, '2.0'),
(8, 2, '1.0'),
(8, 3, '1.0'),
(8, 4, '0.0'),
(8, 5, '0.5'),
(8, 6, '2.0'),
(8, 7, '2.0'),
(8, 8, '1.0'),
(8, 9, '1.0'),
(8, 10, '2.0'),
(8, 11, '1.0'),
(8, 12, '0.5'),
(8, 13, '1.0'),
(8, 14, '1.0'),
(8, 15, '1.0'),
(8, 16, '2.0'),
(8, 17, '1.0'),
(9, 0, '1.0'),
(9, 1, '1.0'),
(9, 2, '2.0'),
(9, 3, '1.0'),
(9, 4, '1.0'),
(9, 5, '1.0'),
(9, 6, '2.0'),
(9, 7, '1.0'),
(9, 8, '1.0'),
(9, 9, '0.5'),
(9, 10, '1.0'),
(9, 11, '1.0'),
(9, 12, '1.0'),
(9, 13, '1.0'),
(9, 14, '1.0'),
(9, 15, '0.0'),
(9, 16, '0.5'),
(9, 17, '1.0'),
(10, 0, '1.0'),
(10, 1, '2.0'),
(10, 2, '0.5'),
(10, 3, '1.0'),
(10, 4, '2.0'),
(10, 5, '1.0'),
(10, 6, '1.0'),
(10, 7, '1.0'),
(10, 8, '0.5'),
(10, 9, '1.0'),
(10, 10, '1.0'),
(10, 11, '2.0'),
(10, 12, '2.0'),
(10, 13, '1.0'),
(10, 14, '1.0'),
(10, 15, '1.0'),
(10, 16, '0.5'),
(10, 17, '1.0'),
(11, 0, '1.0'),
(11, 1, '0.5'),
(11, 2, '1.0'),
(11, 3, '0.5'),
(11, 4, '2.0'),
(11, 5, '2.0'),
(11, 6, '1.0'),
(11, 7, '1.0'),
(11, 8, '2.0'),
(11, 9, '1.0'),
(11, 10, '1.0'),
(11, 11, '0.5'),
(11, 12, '1.0'),
(11, 13, '2.0'),
(11, 14, '1.0'),
(11, 15, '1.0'),
(11, 16, '0.5'),
(11, 17, '1.0'),
(12, 0, '1.0'),
(12, 1, '0.5'),
(12, 2, '0.5'),
(12, 3, '1.0'),
(12, 4, '0.5'),
(12, 5, '2.0'),
(12, 6, '0.5'),
(12, 7, '1.0'),
(12, 8, '1.0'),
(12, 9, '2.0'),
(12, 10, '1.0'),
(12, 11, '1.0'),
(12, 12, '1.0'),
(12, 13, '1.0'),
(12, 14, '0.5'),
(12, 15, '2.0'),
(12, 16, '0.5'),
(12, 17, '0.5'),
(13, 0, '1.0'),
(13, 1, '1.0'),
(13, 2, '1.0'),
(13, 3, '1.0'),
(13, 4, '1.0'),
(13, 5, '1.0'),
(13, 6, '1.0'),
(13, 7, '1.0'),
(13, 8, '1.0'),
(13, 9, '1.0'),
(13, 10, '1.0'),
(13, 11, '1.0'),
(13, 12, '1.0'),
(13, 13, '2.0'),
(13, 14, '1.0'),
(13, 15, '1.0'),
(13, 16, '0.5'),
(13, 17, '0.0'),
(14, 0, '0.0'),
(14, 1, '1.0'),
(14, 2, '1.0'),
(14, 3, '1.0'),
(14, 4, '1.0'),
(14, 5, '1.0'),
(14, 6, '1.0'),
(14, 7, '1.0'),
(14, 8, '1.0'),
(14, 9, '2.0'),
(14, 10, '1.0'),
(14, 11, '1.0'),
(14, 12, '1.0'),
(14, 13, '1.0'),
(14, 14, '2.0'),
(14, 15, '0.5'),
(14, 16, '1.0'),
(14, 17, '1.0'),
(15, 0, '1.0'),
(15, 1, '1.0'),
(15, 2, '0.5'),
(15, 3, '1.0'),
(15, 4, '1.0'),
(15, 5, '1.0'),
(15, 6, '1.0'),
(15, 7, '1.0'),
(15, 8, '1.0'),
(15, 9, '2.0'),
(15, 10, '1.0'),
(15, 11, '1.0'),
(15, 12, '1.0'),
(15, 13, '1.0'),
(15, 14, '2.0'),
(15, 15, '0.5'),
(15, 16, '1.0'),
(15, 17, '0.5'),
(16, 0, '1.0'),
(16, 1, '0.5'),
(16, 2, '1.0'),
(16, 3, '0.5'),
(16, 4, '1.0'),
(16, 5, '1.0'),
(16, 6, '1.0'),
(16, 7, '0.5'),
(16, 8, '1.0'),
(16, 9, '1.0'),
(16, 10, '2.0'),
(16, 11, '2.0'),
(16, 12, '1.0'),
(16, 13, '1.0'),
(16, 14, '1.0'),
(16, 15, '1.0'),
(16, 16, '0.5'),
(16, 17, '2.0'),
(17, 0, '1.0'),
(17, 1, '0.5'),
(17, 2, '2.0'),
(17, 3, '1.0'),
(17, 4, '1.0'),
(17, 5, '1.0'),
(17, 6, '0.5'),
(17, 7, '1.0'),
(17, 8, '1.0'),
(17, 9, '1.0'),
(17, 10, '1.0'),
(17, 11, '1.0'),
(17, 12, '1.0'),
(17, 13, '2.0'),
(17, 14, '1.0'),
(17, 15, '2.0'),
(17, 16, '0.5'),
(17, 17, '1.0');

-- --------------------------------------------------------

--
-- Struttura della tabella `evoluzione`
--

CREATE TABLE `evoluzione` (
  `Evoluto` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Evolvente` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LivelloEvo` smallint(6) DEFAULT NULL,
  `ModEvoluzione` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `StatoEvoluzione` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `evoluzione`
--

INSERT INTO `evoluzione` (`Evoluto`, `Evolvente`, `LivelloEvo`, `ModEvoluzione`, `StatoEvoluzione`) VALUES
('#002', '#001', 16, 'Salire di livello', 1),
('#003', '#002', 32, 'Salire di livello', 2),
('#005', '#004', 16, 'Salire di livello', 1),
('#006', '#005', 36, 'Salire di livello', 2),
('#008', '#007', 16, 'Salire di livello', 1),
('#009', '#008', 36, 'Salire di livello', 2),
('#011', '#010', 7, 'Salire di livello', 1),
('#012', '#011', 10, 'Salire di livello', 2),
('#014', '#013', 7, 'Salire di livello', 1),
('#015', '#014', 10, 'Salire di livello', 2),
('#017', '#016', 18, 'Salire di livello', 1),
('#018', '#017', 36, 'Salire di livello', 2),
('#020', '#019', 20, 'Salire di livello', 1),
('#022', '#021', 20, 'Salire di livello', 1),
('#024', '#023', 22, 'Salire di livello', 1),
('#025', '#172', NULL, 'Aumento Affetto', 1),
('#026', '#025', NULL, 'Uso Pietratuono', 2),
('#028', '#027', 22, 'Salire di livello', 1),
('#030', '#029', 16, 'Salire di livello', 1),
('#031', '#030', NULL, 'Uso Pietralunare', 2),
('#033', '#032', 16, 'Salire di livello', 1),
('#034', '#033', NULL, 'Uso Pietralunare', 2),
('#035', '#173', NULL, 'Tramite Affetto', 1),
('#036', '#035', NULL, 'Uso Pietralunare', 2),
('#038', '#037', NULL, 'Uso Pietrafocaia', 1),
('#039', '#174', NULL, 'Tramite Affetto', 1),
('#040', '#039', NULL, 'Uso Pietralunare', 2),
('#042', '#041', 22, 'Salire di livello', 1),
('#044', '#043', 21, 'Salire di livello', 1),
('#045', '#044', NULL, 'Uso Pietrafoglia', 2),
('#047', '#046', 24, 'Salire di livello', 1),
('#049', '#048', 31, 'Salire di livello', 1),
('#051', '#050', 26, 'Salire di livello', 1),
('#053', '#052', NULL, 'Tramite Affetto', 1),
('#055', '#054', 33, 'Salire di livello', 1),
('#057', '#056', 28, 'Salire di livello', 1),
('#059', '#058', NULL, 'Uso Pietrafocaia', 1),
('#061', '#060', 25, 'Salire di livello', 1),
('#062', '#061', NULL, 'Uso Pietraidrica', 2),
('#064', '#063', 16, 'Salire di livello', 1),
('#065', '#064', NULL, 'Scambio', 2),
('#067', '#066', 28, 'Salire di livello', 1),
('#068', '#067', NULL, 'Scambio', 2),
('#070', '#069', 21, 'Salire di livello', 1),
('#071', '#070', NULL, 'Uso Pietrafoglia', 2),
('#073', '#072', 30, 'Salire di livello', 1),
('#075', '#074', 25, 'Salire di livello', 1),
('#076', '#075', NULL, 'Scambio', 2),
('#078', '#077', 40, 'Salire di livello', 1),
('#080', '#079', 37, 'Salire di livello', 1),
('#082', '#081', 30, 'Salire di livello', 1),
('#085', '#084', 31, 'Salire di livello', 1),
('#087', '#086', 34, 'Salire di livello', 1),
('#089', '#088', 38, 'Salire di livello', 1),
('#169', '#042', NULL, 'Tramite Affetto', 2),
('#182', '#044', NULL, 'Uso Pietrasolare', 2),
('#186', '#061', NULL, 'Scambio con Roccia di Re', 2),
('#199', '#079', NULL, 'Scambio con Roccia di Re', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `generazione`
--

CREATE TABLE `generazione` (
  `IdGen` smallint(6) NOT NULL,
  `NomeGen` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Regione` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `generazione`
--

INSERT INTO `generazione` (`IdGen`, `NomeGen`, `Regione`) VALUES
(1, '1° Generazione', 'Kanto'),
(2, '2° Generazione', 'Johto'),
(3, '3° Generazione', 'Hoenn'),
(4, '4° Generazione', 'Sinnoh'),
(5, '5° Generazione', 'Unima'),
(6, '6° Generazione', 'Kalos'),
(7, '7° Generazione', 'Alola');

-- --------------------------------------------------------

--
-- Struttura della tabella `mosse`
--

CREATE TABLE `mosse` (
  `IdMossa` smallint(6) NOT NULL,
  `NomeMossa` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Potenza` smallint(6) NOT NULL,
  `TipoMossa` smallint(6) DEFAULT NULL,
  `Categoria` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Precisione` smallint(6) DEFAULT NULL,
  `PPBase` smallint(6) NOT NULL,
  `DescrMossa` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `mosse`
--

INSERT INTO `mosse` (`IdMossa`, `NomeMossa`, `Potenza`, `TipoMossa`, `Categoria`, `Precisione`, `PPBase`, `DescrMossa`) VALUES
(1, 'Botta', 40, 0, 'Fisico', 100, 35, 'Colpisce il nemico con la coda o le zampe anteriori'),
(2, 'Colpokarate', 50, 2, 'Fisico', 100, 25, 'Colpisce il nemico con un colpo netto. Probabile brutto colpo'),
(3, 'Doppiasberla', 15, 0, 'Fisico', 85, 10, 'Schiaffeggia il nemico da due a cinque volte di fila'),
(4, 'Cometapugno', 18, 0, 'Fisico', 85, 15, 'Colpisce il nemico con una scarica di pugni da due a cinque volte di fila'),
(5, 'Megapugno', 80, 0, 'Fisico', 85, 20, 'Colpisce il nemico con un pugno poderoso'),
(6, 'Giornopaga', 40, 0, 'Fisico', 100, 20, 'Colpisce il nemico con una gran quantità di monete recuperabili dopo la lotta'),
(7, 'Fuocopugno', 75, 1, 'Fisico', 100, 15, 'Colpisce il nemico con un pugno ardente che può scottarlo'),
(8, 'Gelopugno', 75, 11, 'Fisico', 100, 15, 'Colpisce il nemico con un pugno di ghiaccio che può congelarlo'),
(9, 'Tuonopugno', 75, 7, 'Fisico', 85, 15, 'Colpisce il nemico con un pugno elettrico che può paralizzarlo'),
(10, 'Graffio', 40, 0, 'Fisico', 40, 35, 'Infligge danni al nemico con artigli acuminati, duri e affilati'),
(11, 'Presa', 55, 0, 'Fisico', 100, 30, 'Stringe il nemico in una morsa usando enormi e possenti tenaglie'),
(12, 'Ghigliottina', -1, 0, 'Fisico', 30, 5, 'Attacca il nemico con pericolose tenaglie. Se l''attacco va a segno, il nemico va subito KO'),
(13, 'Ventagliente', 80, 0, 'Speciale', 100, 10, 'Chi la usa genera un turbine al primo turno e attacca al secondo. Probabile brutto colpo'),
(14, 'Danzaspada', 0, 0, 'Status', NULL, 20, 'Danza frenetica che incrementa lo spirito combattivo. Chi la usa aumenta di molto il suo Attacco'),
(15, 'Taglio', 50, 0, 'Fisico', 95, 30, 'Attacca il nemico con artigli o falci affilate. Fuori dalla lotta si usa per tagliare piccoli alberi'),
(16, 'Raffica', 40, 4, 'Speciale', 100, 35, 'Infligge danni al nemico con una folata di vento sollevata dalle ali'),
(17, 'Attacco d''ala', 60, 4, 'Fisico', 100, 35, 'Infligge danni al nemico spiegando delle grandi ali possenti'),
(18, 'Turbine', 0, 0, 'Status', NULL, 20, 'Il bersaglio è spazzato via ed è costretto a lasciare il posto ad un altro. Se è selvatico, la lotta finisce'),
(19, 'Volo', 90, 4, 'Fisico', 95, 15, 'Chi la usa si alza in volo per attaccare al turno seguente. Fuori dalla lotta permette di volare in città già visitate'),
(20, 'Legatutto', 15, 0, 'Fisico', 85, 20, 'Lega e stritola il nemico per quattro o cinque turni con tentacoli o con un corpo lungo'),
(21, 'Schianto', 80, 0, 'Fisico', 75, 20, 'Infligge danni al nemico con una coda, una liana o simili'),
(22, 'Frustata', 45, 5, 'Fisico', 100, 25, 'Infligge danni al nemico con liane sottili simili a fruste'),
(23, 'Pestone', 65, 0, 'Fisico', 100, 20, 'Colpisce il nemico con un grosso piede e può anche farlo tentennare'),
(24, 'Doppiocalcio', 30, 2, 'Fisico', 100, 30, 'Colpisce il nemico due volte con un paio di rapidi calci inferti con entrambi i piedi'),
(25, 'Megacalcio', 120, 0, 'Fisico', 75, 5, 'Colpisce il nemico con un calcio sferrato con la forza di muscoli poderosi'),
(26, 'Calciosalto', 100, 2, 'Fisico', 95, 10, 'Permette di saltare in alto per attaccare con un calcio. Se non va a buon fine, chi la usa si ferisce'),
(27, 'Calciorullo', 60, 2, 'Fisico', 85, 15, 'Chi la usa infierisce sul nemico con un calcio rotante. Può anche farlo tentennare'),
(28, 'Turbosabbia', 0, 8, 'Status', 100, 15, 'Getta sabbia in faccia al nemico e ne riduce la precisione'),
(29, 'Bottintesta', 70, 0, 'Fisico', 100, 15, 'Chi la usa si lancia diritto di testa contro il nemico. Può anche far tentennare'),
(30, 'Incornata', 65, 0, 'Fisico', 100, 25, 'Danneggia il nemico infilzandolo con un corno affilato'),
(31, 'Furia', 15, 0, 'Fisico', 85, 20, 'Infilza il nemico con corna affilate o un becco da due a cinque volte di fila'),
(32, 'Perforcorno', -1, 0, 'Fisico', 30, 5, 'Colpisce il nemico con un corno perforante come un trapano. Se il colpo va a segno, il nemico va KO'),
(33, 'Azione', 40, 0, 'Fisico', 100, 35, 'Attacco fisico che colpisce il nemico investendolo con tutto il corpo'),
(34, 'Corposcontro', 85, 0, 'Fisico', 100, 15, 'Chi la usa carica il nemico con tutto il corpo. Può causarne anche la paralisi'),
(35, 'Avvolgibotta', 15, 0, 'Fisico', 90, 20, 'Avvolge e stritola il nemico con un corpo lungo o con piante rampicanti per quattro o cinque turni'),
(36, 'Riduttore', 90, 0, 'Fisico', 85, 20, 'Carica spericolata con tutto il corpo contro il nemico. Danneggia un po'' anche chi la usa'),
(37, 'Colpo', 120, 0, 'Fisico', 100, 10, 'Assale e attacca il nemico per due o tre turni, ma confonde chi la usa'),
(38, 'Sdoppiatore', 120, 0, 'Fisico', 100, 15, 'Carica spietata e pericolosa che danneggia molto anche chi la usa'),
(39, 'Colpocoda', 0, 0, 'Status', 100, 30, 'Chi la usa agita la coda per distrarre i nemici, riducendone la Difesa'),
(40, 'Velenospina', 15, 6, 'Fisico', 100, 35, 'Colpisce il nemico con un aculeo tossico che può anche avvelenarlo'),
(41, 'Doppio Ago', 25, 12, 'Fisico', 100, 20, 'Colpisce il nemico due volte di seguito con un paio di aghi. Può anche avvelenarlo'),
(42, 'Missilspillo', 25, 12, 'Fisico', 95, 20, 'Il nemico viene colpito da due a cinque volte con spilli appuntiti in rapida successione'),
(43, 'Fulmisguardo', 0, 0, 'Status', 100, 30, 'Il nemico viene guardato con sguardo intimidatorio da occhi acuti. Viene ridotta la difesa dell''avversario'),
(44, 'Morso', 60, 15, 'Fisico', 100, 25, 'Il nemico viene morso da denti affilatissimi che possono farlo tentennare'),
(45, 'Ruggito', 0, 0, 'Status', 100, 40, 'Il Pokémon ruggisce con cattiveria. Viene ridotto l''attacco dell''avversario'),
(46, 'Boato', 0, 0, 'Status', NULL, 20, 'Il bersaglio è costretto a lasciare il campo e viene sostituito. Mette fine alle lotte contro Pokémon selvatici'),
(47, 'Canto', 0, 0, 'Status', 55, 15, 'Una ninna nanna è cantata con voce calma per far addormentare il nemico'),
(48, 'Supersuono', 0, 0, 'Status', 55, 20, 'Chi la usa genera dal proprio corpo strane onde acustiche che possono confondere il nemico'),
(49, 'Sonicboom', 20, 0, 'Speciale', 90, 20, 'Il nemico viene colpito con un suono distruttivo che infligge un danno sempre 20 PS'),
(50, 'Inibitore', 0, 0, 'Status', 100, 20, 'Per quattro turni impedisce al bersaglio di riutilizzare l''ultima mossa usata'),
(51, 'Acido', 40, 6, 'Speciale', 100, 30, 'Colpisce i nemici intorno spruzzando un acido corrosivo. Può anche ridurne la Difesa Speciale'),
(52, 'Braciere', 40, 1, 'Speciale', 100, 25, 'Il Pokémon attacca con piccole fiamme. Possono scottare il nemico'),
(53, 'Lanciafiamme', 90, 1, 'Speciale', 100, 15, 'Il nemico viene colpito da intense fiammate che possono anche scottarlo'),
(54, 'Nebbia', 0, 11, 'Status', NULL, 30, 'Chi la usa attira una nebbia che blocca la riduzione alle statistiche della sua squadra per cinque turni'),
(55, 'Pistolacqua', 40, 3, 'Speciale', 100, 25, 'Il nemico è colpito da un potente getto d''acqua'),
(56, 'Idropompa', 110, 3, 'Speciale', 80, 5, 'Il nemico è travolto da un potente getto d''acqua spruzzato ad altissima pressione.'),
(57, 'Surf', 90, 3, 'Speciale', 100, 15, 'Un''onda enorme sommerge il campo di lotta. Fuori dalla lotta si usa per spostarsi sull''acqua'),
(58, 'Geloraggio', 90, 11, 'Speciale', 100, 10, 'Il nemico è colpito da un raggio di energia gelida che può anche congelarlo'),
(59, 'Bora', 110, 11, 'Speciale', 70, 5, 'Colpisce i bersagli con una tremenda tempesta di ghiaccio che può anche congelarli'),
(60, 'Psicoraggio', 65, 9, 'Speciale', 100, 20, 'Il nemico è attaccato con un raggio psichico. Può anche lasciare il nemico confuso'),
(61, 'Bollaraggio', 65, 3, 'Speciale', 100, 20, 'Colpisce il nemico con una forte scarica di bolle. Può anche ridurne la Velocità'),
(62, 'Raggiaurora', 65, 11, 'Speciale', 100, 20, 'Il nemico viene colpito da un fascio color arcobaleno. Può ridurre l''attacco dell''avversario'),
(63, 'Iper Raggio', 150, 0, 'Speciale', 90, 5, 'Colpisce il nemico con un potente raggio. Chi la usa salta il turno successivo per recuperare energia'),
(64, 'Beccata', 35, 4, 'Fisico', 100, 35, 'Colpisce il nemico con un becco appuntito o un corno'),
(65, 'Perforbecco', 80, 4, 'Fisico', 100, 20, 'Attacco a spirale con un becco aguzzo che fa da trapano'),
(66, 'Sottomissione', 80, 2, 'Fisico', 80, 20, 'Chi la usa carica il nemico in modo spericolato, ma danneggia anche se stesso'),
(67, 'Colpo Basso', -2, 2, 'Fisico', 100, 20, 'Un calcio basso e potente che fa cadere il nemico. Danneggia maggiormente i nemici più pesanti'),
(68, 'Contrattacco', -2, 2, 'Fisico', 100, 20, 'Mossa che contrasta ogni attacco fisico, arrecando il doppio del danno ricevuto'),
(69, 'Mov.Sismico', -2, 2, 'Fisico', 100, 20, '...'),
(70, 'Forza', 80, 0, 'Fisico', 100, 15, 'Colpisce il nemico con un''enorme energia. Fuori dalla lotta si usa per spostare i massi'),
(71, 'Assorbimento', 40, 5, 'Speciale', 100, 15, 'Mossa che assorbe PS. Chi la usa recupera una quantità di PS pari alla metà del danno inferto'),
(72, 'Megassorbimento', 75, 5, 'Speciale', 100, 10, 'Mossa che assorbe PS. Chi la usa recupera un quantità di PS pari alla metà del danno inferto'),
(73, 'Parassiseme', 0, 5, 'Status', 90, 10, 'Vengono piantati semi sul bersaglio. Questi sottraggono PS a ogni turno permettendo a chi la usa di curarsi'),
(74, 'Crescita', 0, 0, 'Status', NULL, 20, 'Provoca la crescita immediata del corpo e l''aumento dell''Attacco e dell''Attacco Speciale di chi la usa'),
(75, 'Foglielama', 55, 5, 'Fisico', 95, 25, 'Foglie taglienti sferzano i nemici intorno. Probabile brutto colpo'),
(76, 'Solaraggio', 120, 5, 'Specia', 100, 10, 'Chi la usa assorbe luce al primo turno per proiettare un raggio intenso al turno successivo'),
(77, 'Velenopolvere', 0, 6, 'Status', 75, 35, 'Una nube di polvere velenosa è sparsa sul nemico. Può avvelenare il bersaglio'),
(78, 'Paralizzante', 0, 5, 'Status', 75, 30, 'Investe il bersaglio con una nuvola di polvere che paralizza'),
(79, 'Sonnifero', 0, 3, 'Status', 75, 15, 'Investe il bersaglio con una grande nuvola di polvere soporifera che lo fa addormentare'),
(80, 'Petalodanza', 120, 5, 'Speciale', 100, 10, 'Attacca il nemico cospargendolo di petali per due o tre turni, ma chi la usa rimane confuso'),
(81, 'Millebave', 0, 12, 'Status', 95, 40, 'Chi la usa produce della seta che avvolge i nemici e ne riduce la Velocità'),
(82, 'Ira Di Drago', 40, 13, 'Speciale', 100, 10, 'Colpisce il nemico con un''onda d''urto generata dall''ira. Questo attacco provoca sempre un danno di 40 PS'),
(83, 'Turbofuoco', 35, 1, 'Speciale', 85, 15, 'Intrappola il bersaglio in un turbine di fuoco che dura per quattro o cinque turni'),
(84, 'Tuonoshock', 40, 7, 'Speciale', 100, 30, 'Danneggia il bersaglio con una scarica elettrica che può anche paralizzarlo'),
(85, 'Fulmine', 90, 7, 'Speciale', 100, 15, 'Il bersaglio viene colpito da una potente scarica elettrica che può anche paralizzarlo'),
(86, 'Tuononda', 0, 7, 'Status', 90, 20, 'Il nemico viene colpito da una debole scarica elettrica che, se va a segno, ne causa la paralisi'),
(87, 'Tuono', 110, 7, 'Speciale', 70, 10, 'Il nemico è colpito da un lampo molto violento che può anche paralizzarlo'),
(88, 'Sassata', 50, 10, 'Fisico', 90, 15, 'Chi la usa solleva una roccia e la lancia contro il nemico'),
(89, 'Terremoto', 100, 8, 'Fisico', 100, 10, 'Chi la usa provoca un potente sisma che colpisce gli altri Pokémon in campo'),
(90, 'Abisso', -1, 8, 'Fisico', NULL, 5, 'Chi la usa crea una spaccatura nel terreno e cerca di gettarvici dentro il nemico. Se va a segno, il nemico va KO'),
(91, 'Fossa', 80, 8, 'Fisico', 100, 10, 'Chi la usa scava al primo turno e attacca al successivo. Fuori dalla lotta fa uscire da alcuni luoghi'),
(92, 'Tossina', 0, 6, 'Status', 90, 10, 'Una mossa che lascia l''obiettivo gravemente avvelenato. Il danno da veleno peggiora ad ogni turno'),
(93, 'Confusione', 50, 9, 'Speciale', 100, 25, 'Colpisce il nemico con una leggera forza telecinetica e può anche confonderlo'),
(94, 'Psichico', 90, 9, 'Status', 100, 10, 'Il nemico viene colpito da una potente forza telecinetica che può anche ridurne la Difesa Speciale'),
(95, 'Ipnosi', 0, 9, 'Status', 60, 20, 'Chi la usa si avvale della suggestione ipnotica per far addormentare il nemico'),
(96, 'Meditazione', 0, 9, 'Status', NULL, 40, 'Il Pokémon medita risvegliando il potere nel profondo del suo corpo ed aumentando il suo Attacco'),
(97, 'Agilità', 0, 9, 'Status', NULL, 30, 'Chi la usa rilassa e alleggerisce il proprio corpo per far salire di molto la Velocità'),
(98, 'Attacco Rapido', 40, 0, 'Fisico', 100, 30, 'Chi la usa colpisce sempre per primo e ad una tale velocità da rendersi quasi invisibile'),
(99, 'Ira', 20, 0, 'Fisico', 100, 20, 'Questa mossa ha il potere di aumentare la statistica Attacco ogni volta che chi la usa viene colpito durante una lotta'),
(100, 'Teletrasporto', 0, 9, 'Status', NULL, 20, 'Fa fuggire dai Pokémon selvatici. Fuori dalla lotta porta all''ultimo Centro Pokémon visitato'),
(101, 'Ombra Notturna', -2, 14, 'Speciale', 100, 15, 'Fa apparire un orribile miraggio al nemico e infligge un danno pari al livello di chi la usa'),
(102, 'Mimica', 0, 0, 'Status', NULL, 10, 'Copia l''ultima mossa usata dal bersaglio. La mossa copiata si può utilizzare fino alla sostituzione del Pokémon'),
(103, 'Stridio', 0, 0, 'Status', 85, 40, 'Stridio assordante che riduce di molto la Difesa del nemico'),
(104, 'Doppioteam', 0, 0, 'Status', NULL, 15, 'Chi la usa si muove in fretta e crea copie illusorie di se stesso che aumentano la capacità di elusione'),
(105, 'Ripresa', 0, 0, 'Status', NULL, 10, 'Una mossa di auto-guarigione. Il Pokémon ripristina i suoi PS fino a metà dei suoi PS massimi'),
(106, 'Rafforzatore', 0, 0, 'Status', NULL, 30, 'Tutti i muscoli del corpo si tonificano per aumentare la Difesa'),
(107, 'Minimizzato', 0, 0, 'Status', NULL, 10, 'Il corpo di chi la usa si comprime e diventa più piccolo. La sua capacità di elusione aumenta di molto'),
(108, 'Muro Di Fumo', 0, 0, 'Status', 100, 20, 'Il Pokémon rilascia un''oscura cortina di fumo che riduce la precisione del nemico'),
(109, 'Stordiraggio', 0, 14, 'Status', 100, 10, 'Il nemico è colpito da un raggio sinistro che lo confonde'),
(110, 'Ritirata', 0, 3, 'Status', NULL, 40, 'Il corpo si ritira nel suo duro guscio per aumentare la Difesa'),
(111, 'Ricciolscudo', 0, 0, 'Status', NULL, 40, 'Chi la usa si raggomitola per nascondere i punti deboli e aumentare la propria Difesa'),
(112, 'Barriera', 0, 9, 'Status', NULL, 20, 'Innalza una barriera resistente che aumenta molto la Difesa'),
(113, 'Schermoluce', 0, 9, 'Status', NULL, 30, 'Innalza una barriera di luce fantastica per ridurre i danni degli attacchi speciali alla squadra per cinque turni'),
(114, 'Nube', 0, 11, 'Status', NULL, 30, 'Chi la usa crea una nube nera che annulla ogni modifica delle statistiche di tutti i Pokémon in campo'),
(115, 'Riflesso', 0, 9, 'Status', NULL, 20, 'Innalza una barriera di luce fantastica per ridurre i danni degli attacchi fisici alla squadra per cinque turni'),
(116, 'Focalenergia', 0, 0, 'Status', NULL, 30, 'Chi la usa fa un profondo respiro e si concentra per rendere più probabili i brutti colpi'),
(117, 'Pazienza', -2, 0, 'Fisico', NULL, 10, 'Chi la usa subisce attacchi per due turni e poi restituisce il danno moltiplicato per due'),
(118, 'Metronomo', 0, 0, 'Status', NULL, 10, 'Chi la usa fa di no con un dito e stimola il cervello a usare a caso una delle tante mosse esistenti'),
(119, 'Speculmossa', 0, 4, 'Status', NULL, 20, 'Chi la usa colpisce il bersaglio copiandone l''ultima mossa usata'),
(120, 'Autodistruzione', 200, 0, 'Fisico', 100, 5, 'Chi la usa esplode e infligge danni agli altri Pokémon in campo, ma poi va KO'),
(121, 'Uovobomba', 100, 0, 'Fisico', 75, 10, 'Colpisce il nemico con un grande uovo scaraventato con enorme forza'),
(122, 'Leccata', 30, 14, 'Fisico', 100, 30, 'Una lingua lunga infligge danni al nemico e può anche paralizzarlo'),
(123, 'Smog', 30, 6, 'Speciale', 70, 20, 'Colpisce il nemico con una scarica di gas maleodoranti. Può anche avvelenarlo'),
(124, 'Fango', 65, 6, 'Speciale', 100, 20, 'Lancio di fango malsano che arreca danno al nemico. Può anche avvelenarlo'),
(125, 'Ossoclava', 65, 8, 'Fisico', 85, 20, 'Il Pokémon colpisce il nemico con un bastone d''osso. Può anche fare tentennare l''obiettivo'),
(126, 'Fuocobomba', 110, 1, 'Speciale', 85, 5, 'Investe il nemico con un''intensa fiammata che fa terra bruciata. Può anche scottarlo'),
(127, 'Cascata', 80, 3, 'Fisico', 100, 15, 'Carica il nemico a grande velocità e può farlo tentennare. Fuori dalla lotta fa risalire le cascate'),
(128, 'Tenaglia', 35, 3, 'Fisico', 85, 10, 'Chi la usa intrappola e stritola il nemico con la sua corazza spessa e forte per quattro o cinque turni'),
(129, 'Comete', 60, 0, 'Speciale', NULL, 20, 'Colpisce i nemici con raggi a forma di stella. Questo attacco è infallibile'),
(130, 'Capocciata', 130, 0, 'Fisico', 100, 10, 'Chi la usa ritira la testa per aumentare la Difesa e poi attacca al turno successivo'),
(131, 'Sparalance', 20, 0, 'Fisico', 100, 15, 'Il nemico viene colpito da due a cinque volte in rapida successione da spilli appuntiti'),
(132, 'Limitazione', 10, 0, 'Fisico', 100, 35, 'Colpisce il nemico con lunghi tentacoli o piante rampicanti. Può anche ridurne la Velocità'),
(133, 'Amnesia', 0, 9, 'Status', NULL, 20, 'Vuoto di memoria che aumenta esponenzialmente la difesa speciale'),
(134, 'Cinèsi', 0, 9, 'Status', 80, 15, 'Chi la usa distrae il bersaglio piegando un cucchiaio e ne riduce la precisione'),
(135, 'Covauova', 0, 0, 'Status', NULL, 10, 'Chi la usa recupera metà dei propri PS massimi. Fuori dalla lotta può anche far trasferire PS ai propri compagni'),
(136, 'Calcinvolo', 130, 2, 'Fisico', 90, 10, 'Chi la usa colpisce il nemico con una ginocchiata in volo: se fallisce, subisce danni'),
(137, 'Squardo Feroce', 0, 0, 'Status', 100, 30, 'Chi la usa spaventa il nemico con uno sguardo terrificante e ne causa la paralisi'),
(138, 'MangiaSogni', 100, 9, 'Speciale', 100, 15, 'Attacco che funziona solo su un nemico che dorme. Chi lo usa riceve metà dei PS persi dal nemico'),
(139, 'Velenogas', 0, 6, 'Status', 90, 40, 'Spruzza in faccia al nemico una nuvola di gas tossico che avvelena'),
(140, 'Attacco Pioggia', 15, 0, 'Fisico', 85, 20, 'Piovono enormi sfere sulla testa del nemico da due a cinque volte di fila'),
(141, 'Sanguisuga', 80, 12, 'Fisico', 100, 10, 'Mossa succhiasangue. Chi la usa recupera una quantità di PS pari alla metà del danno inferto'),
(142, 'Demonbacio', 0, 0, 'Status', 75, 10, 'Chi la usa intimidisce il bersaglio con una faccia paurosa e gli schiocca un bacio che lo fa addormentare'),
(143, 'Aeroattacco', 200, 4, 'Fisico', 90, 5, 'Un attacco in due turni e probabile brutto colpo. Può anche far tentennare il nemico'),
(144, 'Trasformazione', 0, 0, 'Status', NULL, 10, 'Chi la usa si trasforma in una copia esatta del bersaglio per sfruttarne le caratteristiche'),
(145, 'Bolla', 40, 3, 'Speciale', 100, 30, 'Uno spruzzo di bolle viene lanciato sul nemico. Può ridurne la velocità'),
(146, 'Stordipugno', 70, 0, 'Fisico', 100, 10, 'Colpisce il bersaglio con una sequenza di pugni che può anche confonderlo'),
(147, 'Spora', 0, 5, 'Status', 100, 15, 'Nube di spore che fa sempre addormentare il bersaglio'),
(148, 'Flash', -2, 9, 'Speciale', 100, 15, 'Il nemico è attaccato con una strana onda di energia. L''intensità dell''attacco è variabile'),
(149, 'Psiconda', 0, 0, 'Status', NULL, 10, 'Chi la usa si trasforma in una copia esatta del bersaglio per sfruttarne le caratteristiche'),
(150, 'Splash', 0, 0, 'Status', NULL, 40, 'Chi la usa sguazza nell''acqua, senza ottenere alcun effetto'),
(151, 'Scudo Acido', 0, 6, 'Status', NULL, 20, 'Il Pokémon modifica la sua struttura cellulare liquefandosi, per aumentare esponenzialmente la sua difesa'),
(152, 'Martellata', 100, 3, 'Fisico', 90, 10, 'Colpisce il nemico con una grande tenaglia. Probabile brutto colpo'),
(153, 'Esplosione', 250, 0, 'Fisico', 100, 5, 'Chi la usa esplode per infliggere danni agli altri Pokémon attorno, ma va KO'),
(154, 'Sfuriate', 18, 0, 'Fisico', 80, 15, 'Colpisce il nemico con artigli o falci affilate da due a cinque volte in rapida successione'),
(155, 'Ossomerang', 50, 8, 'Fisico', 90, 10, 'Chi la usa lancia l''osso che tiene. L''osso colpisce due volte e ritorna come un vero e proprio boomerang'),
(156, 'Riposo', 0, 9, 'Status', NULL, 10, 'Il Pokémon si addormenta per due turni per curare tutti i PS e qualsiasi problema di stato'),
(157, 'Frana', 75, 10, 'Fisico', 90, 15, 'I nemici vengono colpiti da grandi massi che possono anche farli tentennare'),
(158, 'Iperzanna', 80, 0, 'Fisico', 90, 30, 'Il Pokémon morde il nemico con zanne taglienti. Può anche farlo tentennare'),
(159, 'Affilatore', 0, 0, 'Status', NULL, 30, 'Chi la usa riduce il numero di poligoni sul proprio corpo per accentuarne gli spigoli e aumentare l''Attacco'),
(160, 'Conversione', 0, 0, 'Status', NULL, 30, 'Il tipo di chi la usa muta in quello di una sua mossa a caso'),
(161, 'Tripletta', 80, 0, 'Speciale', 100, 10, 'Colpisce il nemico con tre sfere simultanee che possono anche paralizzarlo, scottarlo o congelarlo'),
(162, 'Superzanna', -2, 0, 'Fisico', 90, 10, 'Chi la usa salta sul nemico azzannandolo con i suoi incisivi affilati e facendogli perdere metà dei PS'),
(163, 'Lacerazione', 70, 0, 'Fisico', 100, 20, 'Attacca il nemico con artigli, falci o altro. Probabile brutto colpo'),
(164, 'Sostituto', 0, 0, 'Status', NULL, 10, 'Chi la usa crea una copia di se stesso usando alcuni PS. La copia serve come esca per il nemico'),
(165, 'Scontro', 50, 0, 'Fisico', 100, 1, 'Mossa da usare solo in caso estremo, quando non si hanno più PP. Danneggia anche chi la usa'),
(166, 'Schizzo', 0, 0, 'Status', NULL, 1, 'Permette a chi la usa di imparare l''ultima mossa usata dal bersaglio. La nuova mossa appresa sostituisce Schizzo'),
(167, 'Triplocalcio', 10, 2, 'Fisico', 90, 10, 'Chi la usa esegue fino a tre calci consecutivi la cui potenza aumenta ad ogni colpo'),
(168, 'Furto', 60, 15, 'Fisico', 100, 25, 'Il Pokémon attacca e contemporaneamente ruba lo strumento tenuto dal nemico. Non ruberà nulla, se si possiede già uno strumento'),
(182, 'Protezione', 0, 0, 'Status', NULL, 10, 'Permette di eludere tutti gli attacchi. Se usata in successione può fallire'),
(184, 'Visotruce', 0, 0, 'Status', 100, 10, 'Chi la usa spaventa il nemico con una faccia terribile e ne riduce di molto la Velocità'),
(229, 'Rapigiro', 20, 0, 'Fisico', 100, 40, 'Un attacco roteante che elimina gli effetti delle mosse Legatutto, Avvolgibotta, Parassiseme e Punte'),
(230, 'Profumino', 0, 0, 'Status', 100, 20, 'Un dolce profumo che alletta il nemico per ridurne l''elusione. Attira anche Pokémon selvatici'),
(235, 'Sintesi', 0, 5, 'Status', NULL, 5, 'Chi la usa recupera PS. Il numero di PS recuperati dipende dalle condizioni atmosferiche'),
(240, 'Pioggiadanza', 0, 3, 'Status', NULL, 5, 'Chi la usa provoca una forte pioggia per cinque turni, potenziando le mosse di tipo Acqua'),
(244, 'Psicamisù', 0, 0, 'Status', 0, 10, 'Chi la usa s''ipnotizza per copiare ogni modifica alle statistiche del bersaglio'),
(257, 'Ondacalda', 95, 1, 'Speciale', 90, 10, 'Chi la usa investe i nemici con una folata di vento caldo. Può anche scottare'),
(334, 'Ferroscudo', 0, 16, 'Status', NULL, 15, 'Il corpo di chi la usa si indurisce come il ferro, facendone salire di molto la Difesa'),
(337, 'Dragartigli', 80, 13, 'Fisico', 100, 15, 'Chi la usa attacca con artigli affilati che graffiano il nemico rapidamente e con grande forza'),
(345, 'Fogliamagica', 60, 5, 'Speciale', NULL, 20, 'Chi la usa sparpaglia strane foglie che inseguono il bersaglio. Questa mossa è infallibile'),
(346, 'Docciascuo', 0, 3, 'Status', 100, 15, 'Chi la usa s''impregna d''acqua indebolendo le mosse di tipo Fuoco finché resta in campo'),
(348, 'Fendifoglia', 90, 5, 'Fisico', 100, 15, 'Colpisce il nemico usando una foglia affilata come una spada. Probabile brutto colpo'),
(352, 'Idropulsar', 60, 3, 'Speciale', 100, 20, 'Il nemico viene colpito da un getto d''acqua potentissimo che può anche confonderlo'),
(366, 'Ventoincoda', 0, 4, 'Status', NULL, 15, 'Chi la usa crea turbolente raffiche di vento che aumentano la sua Velocità e quella di tutti i Pokémon della squadra'),
(382, 'Precedenza', 0, 0, 'Status', NULL, 20, 'Se chi la usa è più veloce del nemico, gli ruba la mossa e gliela ritorce contro con potenza persino maggiore'),
(388, 'Affannoseme', 0, 5, 'Status', NULL, 10, 'Un seme che causa ansia viene piantato sul bersaglio. Ne muta l''abilità in Insonnia e ne previene o rimuove il sonno'),
(394, 'Fuococarica', 120, 1, 'Fisico', 100, 15, 'Chi la usa si ricopre di fuoco e carica il bersaglio, ma subisce il contraccolpo. Può anche scottare'),
(399, 'Neropulsar', 80, 15, 'Speciale', 100, 15, 'Chi la usa emana un''aura impregnata di oscuri pensieri. Può anche far tentennare il Pokémon colpito'),
(401, 'Idrondata', 90, 3, 'Fisico', 90, 10, 'Chi la usa attacca agitando la coda come se fosse una violenta ondata in una tempesta furiosa'),
(402, 'Semebomba', 80, 5, 'Fisico', 100, 15, 'Chi la usa emette una raffica di semi dal guscio duro che colpiscono il bersaglio dall''alto'),
(403, 'Eterelama', 75, 4, 'Speciale', 95, 15, 'Chi la usa attacca con un vento tagliente che squarcia il cielo. Può anche far tentennare il Pokémon colpito'),
(421, 'Ombrartigli', 70, 14, 'Fisico', 100, 15, 'Chi la usa attacca con artigli d''ombra che colpiscono con gran forza. Probabile brutto colpo'),
(424, 'Rogodenti', 65, 1, 'Fisico', 95, 15, 'Chi la usa morde il nemico con denti infuocati. Può causare scottatura e tentennamento'),
(428, 'Cozzata Zen', 80, 9, 'Fisico', 9, 15, 'Chi la usa concentra la forza nella testa e si lancia contro il nemico. Può anche farlo tentennare'),
(430, 'Cannonflash', 80, 16, 'Speciale', 100, 10, 'Chi la usa attacca raccogliendo e rilasciando energia luminosa. Può ridurre la Difesa Speciale del nemico'),
(450, 'Coleomorso', 60, 12, 'Fisico', 100, 20, 'Chi la usa morde il nemico. Inoltre, se questi tiene una Bacca, gliela ruba e ne sfrutta gli effetti'),
(453, 'Acquagetto', 40, 3, 'Fisico', 100, 20, 'Chi la usa colpisce sempre per primo e a una tale velocità da rendersi quasi invisibile'),
(472, 'Mirabilzona', 0, 9, 'Status', NULL, 10, 'Chi la usa crea una dimensione in cui Difesa e Difesa Speciale di tutti i Pokémon vengono scambiate per cinque turni'),
(481, 'Pirolancio', 70, 1, 'Speciale', 100, 15, 'Chi la usa emana una fiammata che colpisce il bersaglio e si propaga fino a raggiungere i Pokémon accanto'),
(487, 'Inondazione', 0, 3, 'Status', 100, 20, 'Chi la usa proietta un lungo getto d''acqua contro il bersaglio e lo rende un Pokémon di tipo Acqua'),
(517, 'Marchiatura', 100, 1, 'Speciale', 50, 5, 'Il bersaglio viene avvolto da intense fiammate che causano scottature'),
(572, 'Fiortempesta', 90, 5, 'Fisico', 100, 15, 'Infligge danni ai Pokémon che ha intorno attaccandoli con una tempesta di fiori');

--
-- Trigger `mosse`
--
DELIMITER $$
CREATE TRIGGER `Insert_ValidaPotenza` BEFORE INSERT ON `mosse` FOR EACH ROW BEGIN 
if(new.potenza > 250 OR new.potenza < -2) THEN SET new.Potenza = -2;
end if; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `natura`
--

CREATE TABLE `natura` (
  `IdNatura` smallint(6) NOT NULL,
  `NomeNatura` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `StatMigliorata` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `StatPeggiorata` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SaporeAmato` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SaporeOdiato` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `natura`
--

INSERT INTO `natura` (`IdNatura`, `NomeNatura`, `StatMigliorata`, `StatPeggiorata`, `SaporeAmato`, `SaporeOdiato`) VALUES
(0, 'Ardita', NULL, NULL, NULL, NULL),
(1, 'Schiva', 'Attacco', 'Difesa', 'Pepato', 'Aspro'),
(2, 'Audace', 'Attacco', 'Velocità', 'Pepato', 'Dolce'),
(3, 'Decisa', 'Attacco', 'Attacco Speciale', 'Pepato', 'Secco'),
(4, 'Birbona', 'Attacco', 'DIfesa Speciale', 'Pepato', 'Amaro'),
(5, 'Sicura', 'Difesa', 'Attacco', 'Aspro', 'Pepato'),
(6, 'Docile', NULL, NULL, NULL, NULL),
(7, 'Placida', 'Difesa', 'Velocità', 'Aspro', 'Dolce'),
(8, 'Scaltra', 'Difesa', 'Attacco Speciale', 'Aspro', 'Secco'),
(9, 'Fiacca', 'Difesa', 'Difesa Speciale', 'Aspro', 'Amaro'),
(10, 'Timida', 'Velocità', 'Attacco', 'Dolce', 'Pepato'),
(11, 'Lesta', 'Velocità', 'Difesa', 'Dolce', 'Aspro'),
(12, 'Seria', NULL, NULL, NULL, NULL),
(13, 'Allegra', 'Velocità', 'Attacco Speciale', 'Dolce', 'Secco'),
(14, 'Ingenua', 'Velocità', 'Difesa Speciale', 'Dolce', 'Amaro'),
(15, 'Modesta', 'Attacco Speciale', 'Attacco', 'Secco', 'Pepato'),
(16, 'Mite', 'Attacco Speciale', 'Difesa', 'Secco', 'Dolce'),
(17, 'Quieta', ' Attacco Speciale', 'Velocità', 'Secco', 'Dolce'),
(18, 'Ritrosa', NULL, NULL, NULL, NULL),
(19, 'Ardente', 'Attacco Speciale', 'Difesa Speciale', 'Secco', 'Amaro'),
(20, 'Calma', 'Difesa Speciale', 'Attacco', 'Amaro', 'Pepato'),
(21, 'Gentile', 'Difesa Speciale', 'Difesa', 'Amaro', 'Aspro'),
(22, 'Vivace', 'Difesa Speciale', 'Velocità', 'Amaro', 'Dolce'),
(23, 'Cauta', ' Difesa Speciale', 'Attacco Speciale', 'Amaro', 'Secco'),
(24, 'Furba', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `pokemon`
--

CREATE TABLE `pokemon` (
  `Nickname` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CeSpecie` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Livello` smallint(6) NOT NULL,
  `CeStrumento` smallint(6) DEFAULT NULL,
  `AffAttuale` smallint(6) NOT NULL,
  `PsAttuale` smallint(6) NOT NULL,
  `AttAttuale` smallint(6) NOT NULL,
  `DifAttuale` smallint(6) NOT NULL,
  `AttSpAttuale` smallint(6) NOT NULL,
  `DifSpAttuale` smallint(6) NOT NULL,
  `VelAttuale` smallint(6) NOT NULL,
  `CeAbilita` smallint(6) DEFAULT NULL,
  `CeNatura` smallint(6) DEFAULT NULL,
  `CeZonaCattura` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `pokemon`
--

INSERT INTO `pokemon` (`Nickname`, `CeSpecie`, `Livello`, `CeStrumento`, `AffAttuale`, `PsAttuale`, `AttAttuale`, `DifAttuale`, `AttSpAttuale`, `DifSpAttuale`, `VelAttuale`, `CeAbilita`, `CeNatura`, `CeZonaCattura`) VALUES
('Ariados1', '#168', 70, 41, 90, 87, 111, 89, 71, 90, 56, 68, 5, 7),
('Cacturne1', '#332', 65, 38, 110, 90, 156, 78, 147, 72, 80, 8, 2, 13),
('Charizard1', '#006', 57, 49, 123, 140, 112, 97, 181, 99, 157, 66, 0, 16),
('Golduck1', '#055', 90, 12, 121, 113, 120, 90, 140, 102, 110, 13, 15, 10),
('Golem1', '#076', 99, 19, 105, 100, 170, 180, 70, 75, 55, 5, 2, 21),
('Groudon1', '#383', 100, 11, 78, 124, 178, 150, 114, 117, 98, 70, 20, 100),
('Groudon2', '#383', 85, 16, 102, 120, 167, 168, 151, 120, 117, 70, 21, 102),
('Ho-Oh1', '#250', 100, 38, 100, 151, 167, 110, 131, 180, 105, 46, 6, 21),
('Kingler1', '#099', 77, 14, 82, 63, 178, 133, 60, 67, 77, 75, 20, 20),
('Kyogre1', '#382', 98, 47, 55, 160, 120, 107, 210, 158, 160, 2, 15, 100),
('Kyogre2', '#382', 100, 54, 200, 127, 111, 120, 198, 167, 130, 2, 0, 100),
('Kyogre3', '#382', 77, 55, 102, 115, 122, 120, 187, 157, 117, 2, 11, 100),
('Ludicolo1', '#272', 67, 35, 90, 110, 90, 95, 130, 142, 89, 44, 15, 11),
('Mew1', '#151', 100, 22, 200, 130, 140, 110, 140, 110, 160, 28, 11, 38),
('Rayquaza1', '#384', 100, 12, 50, 165, 210, 110, 185, 120, 119, 76, 11, 100),
('Rayquaza2', '#384', 94, 22, 70, 162, 208, 112, 190, 115, 121, 76, 15, 102),
('Rhyhorn1', '#111', 72, 41, 90, 113, 117, 128, 50, 50, 38, 31, 8, 36),
('Sceptile1', '#254', 98, 23, 99, 98, 100, 77, 123, 99, 135, 65, 10, 101),
('Scyther1', '#123', 77, 25, 82, 99, 150, 87, 62, 89, 120, 68, 17, 27),
('Shuppet1', '#353', 51, 13, 55, 60, 80, 50, 71, 37, 62, 15, 15, 21);

--
-- Trigger `pokemon`
--
DELIMITER $$
CREATE TRIGGER `Insert_ValidaLivello` BEFORE INSERT ON `pokemon` FOR EACH ROW BEGIN 
if(new.Livello > 100) THEN SET new.Livello = 50;
end if; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `speciepokemon`
--

CREATE TABLE `speciepokemon` (
  `Id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Nome` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Altezza` decimal(3,1) NOT NULL,
  `Peso` decimal(4,1) NOT NULL,
  `Tipo1` smallint(6) DEFAULT '0',
  `Tipo2` smallint(6) DEFAULT NULL,
  `Descrizione` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TassoCattura` decimal(4,2) NOT NULL,
  `AffettoBase` smallint(6) NOT NULL DEFAULT '70',
  `PSBase` smallint(6) NOT NULL,
  `AttBase` smallint(6) NOT NULL,
  `DifBase` smallint(6) NOT NULL,
  `AttSpBase` smallint(6) NOT NULL,
  `DifSpBase` smallint(6) NOT NULL,
  `VelBase` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `speciepokemon`
--

INSERT INTO `speciepokemon` (`Id`, `Nome`, `Altezza`, `Peso`, `Tipo1`, `Tipo2`, `Descrizione`, `TassoCattura`, `AffettoBase`, `PSBase`, `AttBase`, `DifBase`, `AttSpBase`, `DifSpBase`, `VelBase`) VALUES
('#001', 'Bulbasaur', '0.7', '6.9', 5, 6, 'Pokémon Seme', '5.90', 70, 45, 49, 49, 65, 65, 45),
('#002', 'Ivysaur', '1.0', '13.0', 5, 6, 'Pokémon Seme', '5.90', 70, 60, 62, 63, 80, 80, 60),
('#003', 'Venusaur', '2.0', '100.0', 5, 6, 'Pokémon Seme', '5.90', 70, 80, 82, 83, 100, 100, 80),
('#004', 'Charmander', '0.6', '8.5', 1, NULL, 'Pokémon Lucertola', '5.90', 70, 39, 52, 43, 60, 50, 65),
('#005', 'Charmeleon', '1.1', '19.0', 1, NULL, 'Pokémon Fiamma', '5.90', 70, 58, 64, 58, 80, 65, 80),
('#006', 'Charizard', '1.7', '90.5', 1, 6, 'Pokémon Fiamma', '5.90', 70, 78, 84, 78, 109, 85, 100),
('#007', 'Squirtle', '0.5', '9.0', 3, NULL, 'Pokémon Tartaghina', '5.90', 70, 44, 48, 65, 50, 64, 43),
('#008', 'Wartortle', '1.0', '22.5', 3, NULL, 'Pokémon Tartaruga', '5.90', 70, 59, 63, 80, 65, 80, 58),
('#009', 'Blastoise', '1.6', '85.5', 3, NULL, 'Pokémon Crostaceo', '5.90', 70, 79, 83, 100, 85, 105, 78),
('#010', 'Caterpie', '0.3', '2.9', 12, NULL, 'Pokémon Baco', '33.30', 70, 45, 30, 35, 20, 20, 45),
('#011', 'Metapod', '0.7', '9.9', 12, NULL, 'Pokémon Bozzolo', '15.70', 70, 50, 20, 55, 25, 25, 30),
('#012', 'Butterfree', '1.1', '32.0', 12, 4, 'Pokémon Farfalla', '5.90', 70, 60, 45, 50, 90, 80, 70),
('#013', 'Weedle', '0.3', '3.2', 12, 6, 'Pokémon Millepiedi', '33.30', 70, 40, 35, 30, 20, 20, 50),
('#014', 'Kakuna', '0.6', '10.0', 12, 6, 'Pokémon Bozzolo', '15.70', 70, 45, 25, 50, 25, 25, 35),
('#015', 'Beedrill', '1.0', '29.5', 12, 6, 'Pokémon Velenape', '5.90', 70, 65, 90, 40, 45, 80, 75),
('#016', 'Pidgey', '0.3', '1.8', 0, 4, 'Pokémon Uccellino', '33.30', 70, 40, 45, 40, 35, 35, 56),
('#017', 'Pidgeotto', '1.1', '30.0', 0, 4, 'Pokémon Uccello', '15.70', 70, 63, 60, 55, 50, 50, 71),
('#018', 'Pidgeot', '1.5', '39.5', 0, 4, 'Pokémon Uccello', '5.90', 70, 83, 80, 75, 70, 70, 101),
('#019', 'Rattata', '0.3', '3.5', 0, NULL, 'Pokémon Topo', '33.30', 70, 30, 56, 35, 25, 35, 72),
('#020', 'Raticate', '0.7', '18.5', 0, NULL, 'Pokémon Topo', '16.60', 70, 55, 81, 60, 50, 70, 97),
('#021', 'Spearow', '0.3', '2.0', 0, 4, 'Pokémon Uccellino', '33.30', 70, 40, 60, 30, 31, 31, 70),
('#022', 'Fearow', '1.2', '38.0', 0, 4, 'Pokémon Becco', '11.80', 70, 65, 90, 65, 61, 61, 100),
('#023', 'Ekans', '2.0', '6.9', 6, NULL, 'Pokémon Serpente', '33.30', 70, 35, 60, 44, 40, 54, 55),
('#024', 'Arbok', '3.5', '65.0', 6, NULL, 'Pokémon Cobra', '11.80', 70, 60, 95, 69, 65, 79, 80),
('#025', 'Pikachu', '0.4', '6.0', 7, NULL, 'Pokémon Topo', '24.80', 70, 35, 55, 40, 50, 50, 90),
('#026', 'Raichu', '0.8', '30.0', 7, NULL, 'Pokémon Topo', '9.80', 70, 60, 90, 55, 90, 80, 110),
('#027', 'Sandshrew', '0.6', '12.0', 8, NULL, 'Pokémon Topo', '33.30', 70, 50, 75, 85, 20, 30, 40),
('#028', 'Sandslash', '1.0', '29.5', 8, NULL, 'Pokémon Topo', '11.80', 70, 75, 100, 110, 45, 55, 65),
('#029', 'Nidoran♀', '0.4', '7.0', 4, NULL, 'Pokémon Velenago', '30.70', 70, 55, 47, 52, 40, 40, 41),
('#030', 'Nidorina', '0.8', '20.0', 4, NULL, 'Pokémon Velenago', '15.70', 70, 70, 62, 67, 55, 55, 56),
('#031', 'Nidoqueen', '1.3', '60.0', 4, 8, 'Pokémon Trapano', '5.90', 70, 90, 92, 87, 75, 85, 76),
('#032', 'Nidoran♂', '0.5', '9.0', 4, NULL, 'Pokémon Velenago', '30.70', 70, 46, 57, 40, 40, 40, 50),
('#033', 'Nidorino', '0.9', '19.5', 4, NULL, 'Pokémon Velenago', '15.70', 70, 61, 72, 57, 55, 55, 65),
('#034', 'Nidoking', '1.4', '62.0', 4, 8, 'Pokémon Trapano', '5.90', 70, 81, 102, 77, 85, 75, 85),
('#035', 'Clefairy', '0.6', '7.5', 17, NULL, 'Pokémon Fata', '19.60', 140, 70, 45, 48, 60, 65, 35),
('#036', 'Clefable', '1.3', '40.0', 17, NULL, 'Pokémon Fata', '3.30', 140, 95, 70, 73, 95, 90, 60),
('#037', 'Vulpix', '0.6', '9.9', 1, NULL, 'Pokémon Volpe', '24.80', 70, 38, 41, 40, 50, 65, 65),
('#038', 'Ninetales', '1.1', '19.9', 1, NULL, 'Pokémon Volpe', '9.80', 70, 73, 76, 75, 81, 100, 100),
('#039', 'Jigglypuff', '0.9', '19.5', 0, 17, 'Pokémon Pallone', '15.70', 70, 115, 45, 20, 45, 25, 20),
('#040', 'Wigglytuff', '1.0', '12.0', 0, 17, 'Pokémon Pallone', '6.50', 70, 140, 70, 45, 85, 50, 45),
('#041', 'Zubat', '0.8', '7.5', 6, 4, 'Pokémon Pipistrello', '33.30', 70, 40, 45, 35, 30, 40, 55),
('#042', 'Golbat', '1.6', '55.0', 6, 4, 'Pokémon Pipistrello', '11.80', 70, 75, 80, 70, 65, 75, 90),
('#043', 'Oddish', '0.5', '5.0', 5, 6, 'Pokémon Malerba', '33.30', 70, 45, 50, 55, 75, 65, 30),
('#044', 'Gloom', '0.8', '8.6', 5, 6, 'Pokémon Malerba', '15.70', 70, 60, 65, 70, 85, 75, 40),
('#045', 'Vileplume', '1.2', '18.6', 5, 6, 'Pokémon Fiore', '5.90', 70, 75, 80, 85, 110, 90, 50),
('#046', 'Paras', '0.3', '5.4', 12, 5, 'Pokémon Fungo', '24.80', 70, 35, 70, 55, 45, 55, 25),
('#047', 'Parasect', '1.0', '29.5', 12, 5, 'Pokémon Fungo', '9.80', 70, 60, 95, 80, 60, 80, 30),
('#048', 'Venonat', '1.0', '30.0', 12, 6, 'Pokémon Insetto', '24.80', 70, 60, 55, 50, 40, 55, 45),
('#049', 'Venomoth', '1.5', '12.5', 12, 6, 'Pokémon Velentarma', '9.80', 70, 70, 65, 60, 90, 75, 90),
('#050', 'Diglett', '0.2', '0.8', 8, NULL, 'Pokémon Talpa', '33.30', 70, 10, 55, 25, 35, 45, 95),
('#051', 'Dugtrio', '0.7', '33.3', 8, NULL, 'Pokémon Talpa', '6.50', 70, 35, 100, 50, 50, 70, 120),
('#052', 'Meowth', '0.4', '4.2', 0, NULL, 'Pokémon Graffimiao', '33.30', 70, 40, 45, 35, 40, 40, 90),
('#053', 'Persian', '1.0', '32.0', 0, NULL, 'Pokémon Nobilgatto', '11.80', 70, 65, 70, 60, 65, 65, 115),
('#054', 'Psyduck', '0.8', '19.6', 3, NULL, 'Pokémon Papero', '24.80', 70, 50, 52, 48, 65, 50, 55),
('#055', 'Golduck', '1.7', '76.6', 3, NULL, 'Pokémon Papero', '9.80', 70, 80, 82, 78, 95, 80, 85),
('#056', 'Mankey', '0.5', '28.0', 2, NULL, 'Pokémon Suinpanzè', '24.80', 70, 40, 80, 35, 35, 45, 70),
('#057', 'Primeape', '1.0', '32.0', 2, NULL, 'Pokémon Suinpanzè', '9.80', 70, 65, 105, 60, 60, 70, 95),
('#058', 'Growlithe', '0.7', '19.0', 1, NULL, 'Pokémon Cagnolino', '24.80', 70, 55, 70, 45, 70, 50, 60),
('#059', 'Arcanine', '1.9', '155.0', 1, NULL, 'Pokémon Leggenda', '9.80', 70, 90, 110, 80, 100, 80, 95),
('#060', 'Poliwag', '0.6', '12.4', 3, NULL, 'Pokémon Girino', '33.30', 70, 40, 50, 40, 40, 40, 90),
('#061', 'Poliwhirl', '1.0', '20.0', 3, NULL, 'Pokémon Girino', '15.70', 70, 65, 65, 65, 60, 50, 90),
('#062', 'Poliwrath', '1.3', '54.0', 3, 2, 'Pokémon Girino', '5.90', 70, 90, 95, 95, 70, 90, 70),
('#063', 'Abra', '0.9', '19.5', 9, NULL, 'Pokémon Psico', '26.10', 70, 25, 20, 15, 105, 55, 90),
('#064', 'Kadabra', '1.3', '56.5', 9, NULL, 'Pokémon Psico', '13.10', 70, 40, 35, 30, 120, 70, 105),
('#065', 'Alakazam', '2.0', '48.0', 9, NULL, 'Pokémon Psico', '6.50', 70, 55, 50, 45, 135, 95, 120),
('#066', 'Machop', '0.7', '19.5', 2, NULL, 'Pokémon Megaforza', '23.50', 70, 70, 80, 50, 35, 35, 35),
('#067', 'Machoke', '1.5', '70.5', 2, NULL, 'Pokémon Megaforza', '11.80', 70, 80, 100, 70, 50, 60, 45),
('#068', 'Machamp', '1.6', '130.0', 2, NULL, 'Pokémon Megaforza', '5.90', 70, 90, 130, 80, 65, 85, 55),
('#069', 'Bellsprout', '0.7', '4.0', 5, 6, 'Pokémon Fiore', '33.30', 70, 50, 75, 35, 70, 30, 40),
('#070', 'Weepinbell', '1.0', '6.4', 5, 6, 'Pokémon Moschivoro', '15.70', 70, 65, 90, 50, 85, 45, 55),
('#071', 'Victreebel', '1.7', '15.5', 5, 6, 'Pokémon Moschivoro', '5.90', 70, 80, 105, 65, 100, 70, 70),
('#072', 'Tentacool', '0.9', '45.5', 3, 6, 'Pokémon Medusa', '24.80', 70, 40, 40, 35, 50, 100, 70),
('#073', 'Tentacruel', '1.6', '55.0', 3, 6, 'Pokémon Medusa', '7.80', 70, 80, 70, 65, 80, 120, 100),
('#074', 'Geodude', '0.4', '20.0', 10, 8, 'Pokémon Roccia', '33.30', 70, 40, 80, 100, 30, 30, 20),
('#075', 'Graveler', '1.0', '105.0', 10, 8, 'Pokémon Roccia', '15.70', 70, 55, 95, 115, 45, 45, 35),
('#076', 'Golem', '1.4', '300.0', 10, 8, 'Pokémon Megatone', '5.90', 70, 80, 120, 130, 55, 65, 45),
('#077', 'Ponyta', '1.0', '30.0', 1, NULL, 'Pokémon Cavalfuoco', '24.80', 70, 50, 85, 55, 65, 65, 90),
('#078', 'Rapidash', '1.7', '95.0', 1, NULL, 'Pokémon Cavalfuoco', '7.80', 70, 65, 100, 70, 80, 80, 105),
('#079', 'Slowpoke', '1.2', '36.0', 3, 9, 'Pokémon Ronfone', '24.80', 70, 90, 65, 65, 40, 40, 15),
('#080', 'Slowbro', '1.6', '78.5', 3, 9, 'Pokémon Paguro', '9.80', 70, 95, 75, 110, 100, 80, 30),
('#081', 'Magnemite', '0.3', '6.0', 7, 16, 'Pokémon Calamita', '24.80', 70, 25, 35, 70, 95, 55, 45),
('#082', 'Magneton', '1.0', '60.0', 7, 16, 'Pokémon Calamita', '7.80', 70, 50, 60, 95, 120, 70, 70),
('#083', 'Farfetch''d', '0.8', '15.0', 0, 4, 'Pokémon Selvanatra', '5.90', 70, 52, 90, 55, 58, 62, 60),
('#084', 'Doduo', '1.4', '39.2', 0, 4, 'Pokémon Biuccello', '24.80', 70, 35, 85, 45, 35, 35, 75),
('#085', 'Dodrio', '1.8', '85.2', 0, 4, 'Pokémon Triuccello', '5.90', 70, 60, 110, 70, 60, 60, 110),
('#086', 'Seel', '1.1', '90.0', 3, NULL, 'Pokémon Otaria', '24.80', 70, 65, 45, 55, 45, 70, 45),
('#087', 'Dewgong', '1.7', '120.0', 3, 11, 'Pokémon Otaria', '9.80', 70, 90, 70, 80, 70, 95, 70),
('#088', 'Grimer', '0.9', '30.0', 6, NULL, 'Pokémon Melma', '24.80', 70, 80, 80, 50, 40, 50, 25),
('#089', 'Muk', '1.2', '30.0', 6, NULL, 'Pokémon Melma', '9.80', 70, 105, 105, 75, 65, 100, 50),
('#090', 'Shellder', '0.3', '4.0', 3, NULL, 'Pokémon Bivalve', '24.80', 70, 30, 65, 100, 45, 25, 40),
('#091', 'Cloyster', '1.5', '132.5', 3, 11, 'Pokémon Bivalve', '7.80', 70, 50, 95, 180, 85, 45, 70),
('#092', 'Gastly', '1.3', '0.1', 14, 6, 'Pokémon Gas', '24.80', 70, 30, 35, 30, 100, 35, 80),
('#093', 'Haunter', '1.6', '0.1', 14, 6, 'Pokémon Gas', '11.80', 70, 45, 50, 45, 115, 55, 95),
('#094', 'Gengar', '1.5', '40.5', 14, 6, 'Pokémon Ombra', '5.90', 70, 60, 65, 60, 130, 75, 110),
('#095', 'Onix', '8.8', '210.0', 10, 8, 'Pokémon Serpesasso', '5.90', 70, 35, 45, 160, 30, 45, 70),
('#096', 'Drowzee', '1.0', '32.4', 9, NULL, 'Pokémon Ipnosi', '24.80', 70, 60, 48, 45, 43, 90, 42),
('#097', 'Hypno', '1.6', '75.6', 9, NULL, 'Pokémon Ipnosi', '9.80', 70, 85, 73, 70, 73, 115, 67),
('#098', 'Krabby', '0.4', '6.5', 3, NULL, 'Pokémon Granchio', '29.40', 70, 30, 105, 90, 25, 25, 50),
('#099', 'Kingler', '1.3', '60.0', 3, NULL, 'Pokémon Chela', '7.80', 70, 55, 130, 115, 50, 50, 75),
('#100', 'Voltorb', '0.5', '10.4', 7, NULL, 'Pokémon Ball', '24.80', 70, 40, 30, 50, 55, 55, 100),
('#101', 'Electrode', '1.2', '66.6', 7, NULL, 'Pokémon Ball', '7.80', 70, 60, 50, 70, 80, 80, 150),
('#102', 'Exeggcute', '0.4', '2.5', 5, 9, 'Pokémon Uovo', '11.80', 70, 60, 40, 80, 60, 45, 40),
('#103', 'Exeggutop', '2.0', '120.0', 5, 9, 'Pokémon Nocecocco', '5.90', 70, 95, 95, 85, 125, 75, 55),
('#104', 'Cubone', '0.4', '6.5', 8, NULL, 'Pokémon Solitario', '24.80', 70, 50, 50, 95, 40, 50, 35),
('#105', 'Marowak', '1.0', '45.0', 8, NULL, 'Pokémon Guardaossi', '9.80', 70, 60, 80, 110, 50, 80, 45),
('#106', 'Hitmonlee', '1.5', '49.8', 2, NULL, 'Pokémon Tiracalci', '5.90', 70, 50, 120, 53, 35, 110, 87),
('#107', 'Hitmonchan', '1.4', '50.2', 2, NULL, 'Pokémon Tirapugni', '5.90', 70, 50, 105, 79, 35, 110, 76),
('#108', 'Licktung', '1.2', '65.5', 0, NULL, 'Pokémon Linguaccia', '5.90', 70, 90, 55, 75, 60, 75, 30),
('#109', 'Koffing', '0.6', '1.0', 6, NULL, 'Pokémon Velenuvola', '24.80', 70, 40, 65, 95, 60, 45, 35),
('#110', 'Weezing', '1.2', '9.5', 6, NULL, 'Pokémon Velenuvola', '7.80', 70, 65, 90, 120, 85, 70, 60),
('#111', 'Rhyhorn', '1.0', '115.0', 8, 10, 'Pokémon Punzoni', '15.70', 70, 80, 85, 95, 30, 30, 25),
('#112', 'Rhydon', '1.9', '120.0', 8, 10, 'Pokémon Trapano', '7.80', 70, 105, 130, 120, 45, 45, 40),
('#113', 'Chansey', '1.1', '34.6', 0, NULL, 'Pokémon Uovo', '3.90', 140, 250, 5, 5, 35, 105, 50),
('#114', 'Tangela', '1.0', '35.0', 5, NULL, 'Pokémon Liana', '5.90', 70, 65, 55, 115, 100, 40, 60),
('#115', 'Kanganskhan', '2.2', '80.0', 0, NULL, 'Pokémon Genitore', '5.90', 70, 105, 95, 80, 40, 80, 90),
('#116', 'Horsea', '0.4', '8.0', 3, NULL, 'Pokémon Drago', '29.40', 70, 30, 40, 70, 70, 25, 60),
('#117', 'Seadra', '1.2', '25.0', 3, NULL, 'Pokémon Drago', '9.80', 70, 55, 65, 95, 95, 45, 85),
('#118', 'Goldeen', '0.6', '15.0', 3, NULL, 'Pokémon Pescerosso', '29.40', 70, 45, 67, 60, 35, 50, 63),
('#119', 'Seaking', '1.3', '39.0', 3, NULL, 'Pokémon Pescerosso', '7.80', 70, 80, 92, 65, 65, 80, 68),
('#120', 'Staryu', '0.8', '34.5', 3, NULL, 'Pokémon Stella', '29.40', 70, 30, 45, 55, 70, 55, 85),
('#121', 'Starmie', '1.1', '80.0', 3, 9, 'Pokémon Misterioso', '7.80', 70, 60, 75, 85, 100, 85, 115),
('#122', 'Mr.Mime', '1.3', '54.5', 9, 17, 'Pokémon Barriera', '5.90', 70, 40, 45, 65, 100, 120, 90),
('#123', 'Scyther', '1.5', '56.0', 12, 4, 'Pokémon Mantide', '5.90', 70, 70, 110, 80, 55, 80, 105),
('#124', 'Jynx', '1.4', '40.6', 11, 9, 'Pokémon Umanoide', '5.90', 70, 65, 50, 35, 115, 95, 95),
('#125', 'Electabuzz', '1.1', '30.0', 7, NULL, 'Pokémon Elettrico', '5.90', 70, 65, 83, 57, 95, 85, 105),
('#126', 'Magmar', '1.3', '44.5', 1, NULL, 'Pokémon Sputafuoco', '5.90', 70, 65, 95, 57, 100, 85, 93),
('#127', 'Pinsir', '1.5', '55.0', 12, NULL, 'Pokémon Cervolante', '5.90', 70, 65, 125, 100, 55, 70, 85),
('#128', 'Tauros', '1.4', '88.4', 0, NULL, 'Pokémon Torobrado', '5.90', 70, 75, 100, 95, 40, 70, 110),
('#129', 'Magikarp', '0.9', '10.0', 3, NULL, 'Pokémon Pesce', '33.30', 70, 20, 10, 55, 15, 20, 80),
('#130', 'Gyarados', '6.5', '235.0', 3, 4, 'Pokémon Atroce', '5.90', 70, 95, 125, 79, 60, 100, 81),
('#131', 'Lapras', '2.5', '220.0', 3, 11, 'Pokémon Trasporto', '5.90', 70, 130, 85, 80, 85, 95, 60),
('#132', 'Ditto', '0.3', '4.0', 0, NULL, 'Pokémon Mutante', '4.60', 70, 48, 48, 48, 48, 48, 48),
('#133', 'Eevee', '0.3', '6.5', 0, NULL, 'Pokémon Evoluzione', '5.90', 70, 55, 55, 50, 45, 65, 55),
('#134', 'Vaporeon', '1.0', '29.0', 3, NULL, 'Pokémon Bollajet', '5.90', 70, 130, 65, 60, 110, 95, 65),
('#135', 'Jolteon', '0.8', '24.5', 7, NULL, 'Pokémon Luminoso', '5.90', 70, 65, 65, 60, 110, 95, 130),
('#136', 'Flareon', '0.9', '25.0', 1, NULL, 'Pokémon Fiamma', '5.90', 70, 65, 130, 60, 95, 110, 65),
('#137', 'Porygon', '0.8', '36.5', 0, NULL, 'Pokémon Virtuale', '5.90', 70, 65, 60, 70, 85, 75, 40),
('#138', 'Omanyte', '0.4', '7.5', 10, 3, 'Pokémon Spirale', '5.90', 70, 35, 40, 100, 90, 55, 35),
('#139', 'Omastar', '1.0', '35.0', 10, 3, 'Pokémon Spirale', '5.90', 70, 70, 60, 125, 115, 70, 55),
('#140', 'Kabuto', '0.5', '11.5', 10, 3, 'Pokémon Crostaceo', '5.90', 70, 30, 80, 90, 55, 45, 55),
('#141', 'Kabutops', '1.3', '40.5', 10, 3, 'Pokémon Crostaceo', '5.90', 70, 60, 115, 105, 65, 70, 80),
('#142', 'Aerodactyl', '1.8', '59.0', 10, 4, 'Pokémon Fossile', '5.90', 70, 80, 105, 65, 60, 75, 130),
('#143', 'Snorlax', '2.1', '460.0', 0, NULL, 'Pokémon Sonno', '3.30', 70, 160, 110, 65, 65, 110, 30),
('#144', 'Articuno', '1.7', '55.4', 11, 4, 'Pokémon Gelo', '0.40', 35, 90, 85, 100, 95, 125, 85),
('#145', 'Zapdos', '1.6', '52.6', 7, 4, 'Pokémon Elettrico', '0.40', 35, 90, 90, 85, 125, 90, 100),
('#146', 'Moltres', '2.0', '60.0', 1, 4, 'Pokémon Fiamma', '0.40', 35, 90, 100, 90, 125, 85, 90),
('#147', 'Dratini', '1.8', '3.3', 13, NULL, 'Pokémon Drago', '5.90', 35, 41, 64, 45, 50, 50, 50),
('#148', 'Dragonair', '4.0', '16.5', 13, NULL, 'Pokémon Drago', '5.90', 35, 61, 84, 65, 70, 70, 70),
('#149', 'Dragonite', '2.2', '210.0', 13, 4, 'Pokémon Drago', '5.90', 35, 91, 134, 95, 100, 100, 80),
('#150', 'Mewtwo', '2.0', '122.0', 9, NULL, 'Pokémon Genetico', '0.40', 0, 106, 110, 90, 154, 90, 130),
('#151', 'Mew', '0.4', '4.0', 9, NULL, 'Pokémon Novaspecie', '5.90', 100, 100, 100, 100, 100, 100, 100),
('#152', 'Chikorita', '0.9', '6.4', 5, NULL, 'Pokémon Foglia', '5.90', 70, 45, 49, 65, 49, 65, 45),
('#153', 'Bayleef', '1.2', '15.8', 5, NULL, 'Pokémon Foglia', '5.90', 70, 60, 62, 80, 63, 80, 60),
('#154', 'Meganium', '1.8', '100.5', 5, NULL, 'Pokémon Erbe', '5.90', 70, 80, 82, 100, 83, 100, 80),
('#155', 'Cyndaquil', '0.5', '7.9', 1, NULL, 'Pokémon Fuocotopo', '5.90', 70, 39, 52, 43, 60, 50, 65),
('#156', 'Quilava', '0.9', '19.0', 1, NULL, 'Pokémon Vulcano', '5.90', 70, 58, 64, 58, 80, 65, 80),
('#157', 'Typhlosion', '1.7', '79.5', 1, NULL, 'Pokémon Vulcano', '5.90', 70, 78, 84, 78, 109, 85, 100),
('#158', 'Totodile', '0.6', '9.5', 3, NULL, 'Pokémon Mascellone', '5.90', 70, 50, 65, 64, 44, 48, 43),
('#159', 'Croconaw', '1.1', '25.0', 3, NULL, 'Pokémon Mascellone', '5.90', 70, 65, 80, 80, 59, 63, 58),
('#160', 'Feraligart', '2.3', '88.8', 3, NULL, 'Pokémon Mascellone', '5.90', 70, 85, 105, 100, 79, 83, 78),
('#161', 'Sentret', '0.8', '6.0', 0, NULL, 'Pokémon Esplorante', '33.30', 70, 35, 46, 34, 35, 45, 20),
('#162', 'Furret', '1.8', '32.5', 0, NULL, 'Pokémon Lungocorpo', '11.80', 70, 85, 76, 64, 45, 55, 90),
('#163', 'Hoothoot', '0.7', '21.2', 0, 4, 'Pokémon Gufo', '33.30', 70, 60, 30, 30, 36, 56, 50),
('#164', 'Noctowl', '1.6', '40.8', 0, 4, 'Pokémon Gufo', '11.80', 70, 100, 50, 50, 86, 96, 70),
('#165', 'Ledyba', '1.0', '10.8', 12, 4, 'Pokémon Pentastra', '33.30', 70, 40, 20, 30, 40, 80, 55),
('#166', 'Ledian', '1.4', '35.6', 12, 4, 'Pokémon Pentastra', '11.80', 70, 55, 35, 50, 55, 110, 85),
('#167', 'Spinarak', '0.5', '8.5', 12, 6, 'Pokémon Tela', '33.30', 70, 40, 60, 40, 40, 40, 30),
('#168', 'Ariados', '1.1', '33.5', 12, 6, 'Pokémon Lungazampa', '11.80', 70, 70, 90, 70, 60, 70, 40),
('#169', 'Crobat', '1.8', '75.0', 6, 4, 'Pokémon Pipistrello', '11.80', 70, 85, 90, 80, 70, 80, 130),
('#170', 'Chinchou', '0.5', '12.0', 3, 7, 'Pokémon Pescatore', '24.80', 70, 75, 38, 38, 56, 56, 67),
('#171', 'Lanturn', '1.2', '22.5', 3, 7, 'Pokémon Luce', '9.80', 70, 125, 58, 58, 76, 76, 67),
('#172', 'Pichu', '0.3', '2.0', 7, NULL, 'Pokémon Topino', '24.80', 70, 20, 40, 15, 35, 35, 60),
('#173', 'Cleffa', '0.3', '3.0', 17, NULL, 'Pokémon Stella', '19.60', 140, 50, 25, 28, 45, 55, 15),
('#174', 'Igglybuff', '0.3', '1.0', 0, 17, 'Pokémon Pallone', '22.20', 70, 90, 30, 15, 40, 20, 15),
('#175', 'Togepi', '0.3', '1.5', 17, NULL, 'Pokémon Pallapunte', '24.80', 70, 35, 20, 65, 40, 65, 20),
('#176', 'Togetic', '0.6', '3.2', 17, 4, 'Pokémon Felicità', '9.80', 70, 55, 40, 85, 80, 105, 40),
('#177', 'Natu', '0.2', '2.0', 9, 4, 'Pokémon Uccellino', '24.80', 70, 40, 50, 45, 70, 45, 70),
('#178', 'Xatu', '1.5', '15.0', 9, 4, 'Pokémon Magico', '9.80', 70, 65, 75, 70, 95, 70, 95),
('#179', 'Mareep', '0.6', '7.8', 7, NULL, 'Pokémon Lana', '30.70', 70, 55, 40, 40, 65, 45, 35),
('#180', 'Flaaffy', '0.8', '13.3', 7, NULL, 'Pokémon Lana', '15.70', 70, 70, 55, 55, 80, 60, 45),
('#181', 'Ampharos', '1.4', '61.5', 7, NULL, 'Pokémon Luce', '5.90', 70, 90, 75, 85, 115, 90, 55),
('#182', 'Bellossom', '0.4', '5.8', 5, NULL, 'Pokémon Fiore', '5.90', 70, 75, 80, 95, 90, 100, 50),
('#183', 'Marill', '0.4', '8.5', 3, 17, 'Pokémon Acquatopo', '24.80', 70, 70, 20, 50, 20, 50, 40),
('#184', 'Azumarill', '0.8', '28.5', 3, 17, 'Pokémon Acquaniglio', '9.80', 70, 100, 50, 80, 60, 80, 50),
('#185', 'Sudowoodo', '1.2', '38.0', 10, NULL, 'Pokémon Imitazione', '8.50', 70, 70, 100, 115, 30, 65, 30),
('#186', 'Politoed', '1.1', '33.9', 3, NULL, 'Pokémon Rana', '5.90', 70, 90, 75, 75, 90, 100, 70),
('#187', 'Hoppip', '0.4', '0.5', 5, 4, 'Pokémon Gramigna', '33.30', 70, 35, 35, 40, 35, 55, 50),
('#188', 'Skiploom', '0.6', '1.0', 5, 4, 'Pokémon Gramigna', '15.70', 70, 55, 45, 50, 45, 65, 80),
('#189', 'Jumpluff', '0.8', '3.0', 5, 4, 'Pokémon Gramigna', '5.90', 70, 75, 55, 70, 55, 95, 110),
('#190', 'Aipom', '0.8', '11.5', 0, NULL, 'Pokémon Lungacoda', '5.90', 70, 55, 70, 55, 40, 55, 85),
('#191', 'Sunkern', '0.3', '1.8', 5, NULL, 'Pokémon Seme', '30.70', 70, 30, 30, 30, 30, 30, 30),
('#192', 'Sunflora', '0.8', '8.5', 5, NULL, 'Pokémon Sole', '15.70', 70, 75, 75, 55, 105, 85, 30),
('#193', 'Yanma', '1.2', '38.0', 12, 4, 'Pokémon Alachiara', '9.80', 70, 65, 65, 45, 75, 45, 95),
('#194', 'Wooper', '0.4', '8.5', 3, 8, 'Pokémon Acquapesce', '33.30', 70, 55, 45, 45, 25, 25, 15),
('#195', 'Quaqsire', '1.4', '75.0', 3, 8, 'Pokémon Acquapesce', '11.80', 70, 95, 85, 85, 65, 65, 35),
('#196', 'Espeon', '0.9', '26.5', 9, NULL, 'Pokémon Sole', '5.90', 70, 65, 65, 60, 130, 95, 110),
('#197', 'Umbreon', '1.0', '27.0', 15, NULL, 'Pokémon Lucelunare', '5.90', 35, 95, 65, 110, 60, 130, 65),
('#198', 'Murkrow', '0.5', '2.1', 15, 4, 'Pokémon Oscurità', '3.90', 35, 60, 85, 42, 85, 42, 91),
('#199', 'Slowking', '2.0', '79.5', 3, 9, 'Pokémon Reale', '9.20', 70, 95, 75, 80, 100, 110, 30),
('#200', 'Misdreavus', '0.7', '1.0', 14, NULL, 'Pokémon Stridio', '5.90', 35, 60, 60, 60, 85, 85, 85),
('#201', 'Unown', '0.5', '5.0', 9, NULL, 'Pokémon Simbolo', '29.40', 70, 48, 72, 48, 72, 48, 48),
('#202', 'Wobbuffet', '1.3', '28.5', 9, NULL, 'Pokémon Pazienza', '5.90', 70, 190, 33, 58, 33, 58, 33),
('#203', 'Girafarig', '1.5', '41.5', 0, 9, 'Pokémon Lungocollo', '7.80', 70, 70, 80, 65, 90, 65, 85),
('#204', 'Pineco', '0.6', '7.2', 12, NULL, 'Pokémon Larva', '24.80', 70, 50, 65, 90, 35, 35, 15),
('#205', 'Forretress', '1.2', '125.8', 12, 16, 'Pokémon Larva', '9.80', 70, 75, 90, 140, 60, 60, 40),
('#206', 'Dunsparce', '1.5', '14.0', 0, NULL, 'Pokémon Terraserpe', '24.80', 70, 100, 70, 70, 65, 65, 45),
('#207', 'Gligar', '1.1', '64.8', 8, 4, 'Pokémon Aliscorpio', '7.80', 70, 65, 75, 105, 35, 65, 85),
('#208', 'Steelix', '9.2', '400.0', 16, 8, 'Pokémon Ferroserpe', '3.30', 70, 75, 85, 200, 55, 65, 30),
('#209', 'Snubull', '0.6', '7.8', 17, NULL, 'Pokémon Fata', '24.80', 70, 60, 80, 50, 40, 40, 30),
('#210', 'Granbull', '1.4', '48.7', 17, NULL, 'Pokémon Fata', '9.80', 70, 90, 120, 75, 60, 60, 45),
('#211', 'Qwilfish', '0.5', '3.9', 3, 6, 'Pokémon Pallone', '5.90', 70, 65, 95, 85, 55, 55, 85),
('#212', 'Scizor', '1.8', '118.0', 12, 16, 'Pokémon Chele', '3.30', 70, 70, 130, 100, 55, 80, 65),
('#213', 'Shuckle', '0.6', '20.5', 12, 10, 'Pokémon Muffa', '24.80', 70, 20, 10, 230, 10, 230, 5),
('#214', 'Heracross', '1.5', '54.0', 12, 2, 'Pokémon Monocorno', '5.90', 70, 80, 125, 75, 40, 95, 85),
('#215', 'Sneasel', '0.9', '28.0', 15, 11, 'Pokémon Lamartigli', '7.80', 35, 55, 95, 55, 35, 75, 115),
('#216', 'Teddiursa', '0.6', '8.8', 0, NULL, 'Pokémon Orsetto', '15.70', 70, 60, 80, 50, 50, 50, 40),
('#217', 'Ursaring', '1.8', '125.8', 0, NULL, 'Pokémon Letargo', '7.80', 70, 90, 130, 75, 75, 75, 55),
('#218', 'Slugma', '0.7', '35.0', 1, NULL, 'Pokémon Lava', '24.80', 70, 40, 40, 40, 70, 40, 20),
('#219', 'Magcargo', '0.8', '55.0', 1, 10, 'Pokémon Lava', '9.80', 70, 60, 50, 120, 90, 80, 30),
('#220', 'Swinub', '0.4', '6.5', 11, 8, 'Pokémon Maiale', '29.40', 70, 50, 50, 40, 30, 30, 50),
('#221', 'Piloswine', '1.1', '55.8', 11, 8, 'Pokémon Suino', '9.80', 70, 100, 100, 80, 60, 60, 50),
('#222', 'Corsola', '0.6', '5.0', 3, 10, 'Pokémon Corallo', '7.80', 70, 65, 55, 95, 65, 95, 35),
('#223', 'Remoraid', '0.6', '12.0', 3, NULL, 'Pokémon Jet', '24.80', 70, 35, 65, 35, 65, 35, 65),
('#224', 'Octillery', '0.9', '28.5', 3, NULL, 'Pokémon Jet', '9.80', 70, 75, 105, 75, 105, 75, 45),
('#225', 'Delibird', '0.9', '16.0', 11, 4, 'Pokémon Consegna', '5.90', 70, 45, 55, 45, 65, 45, 75),
('#226', 'Mantine', '2.1', '220.0', 3, 4, 'Pokémon Aquilone', '3.30', 70, 85, 40, 70, 80, 140, 70),
('#227', 'Skarmory', '1.7', '50.5', 16, 4, 'Pokémon Armuccello', '3.30', 70, 65, 80, 140, 40, 70, 70),
('#228', 'Houndour', '0.6', '10.8', 15, 1, 'Pokémon Buio', '15.70', 35, 45, 60, 30, 80, 50, 65),
('#229', 'Houndoom', '1.4', '35.0', 15, 1, 'Pokémon Buio', '5.90', 35, 75, 90, 50, 110, 80, 95),
('#230', 'Kingdra', '1.8', '152.0', 3, 13, 'Pokémon Drago', '5.90', 70, 75, 95, 95, 95, 95, 85),
('#231', 'Phanpy', '0.5', '33.5', 8, NULL, 'Pokémon Nasone', '15.70', 70, 90, 60, 60, 40, 40, 40),
('#232', 'Donphan', '1.1', '120.0', 8, NULL, 'Pokémon Armatura', '7.80', 70, 90, 120, 120, 60, 60, 50),
('#233', 'Porygon2', '0.6', '32.5', 0, NULL, 'Pokémon Virtuale', '5.90', 70, 85, 80, 90, 105, 95, 60),
('#234', 'Stantler', '1.4', '71.2', 0, NULL, 'Pokémon Grancorno', '5.90', 70, 73, 95, 62, 85, 65, 85),
('#235', 'Smeargle', '1.2', '58.0', 0, NULL, 'Pokémon Pittore', '5.90', 70, 55, 20, 35, 20, 45, 75),
('#236', 'Tyrogue', '0.7', '21.0', 2, NULL, 'Pokémon Baruffa', '9.80', 70, 35, 35, 35, 35, 35, 35),
('#237', 'Hitmontop', '1.4', '48.0', 2, NULL, 'Pokémon Verticale', '5.90', 70, 50, 95, 95, 35, 110, 70),
('#238', 'Smoochum', '0.4', '6.0', 11, 9, 'Pokémon Bacio', '5.90', 70, 45, 30, 15, 85, 65, 65),
('#239', 'Elekid', '0.6', '23.5', 7, NULL, 'Pokémon Elettrico', '5.90', 70, 45, 63, 37, 65, 55, 95),
('#240', 'Magby', '0.7', '21.4', 1, NULL, 'Pokémon Carbonvivo', '5.90', 70, 45, 75, 37, 70, 55, 83),
('#241', 'Miltank', '1.2', '75.5', 0, NULL, 'Pokémon Bovino', '5.90', 70, 95, 80, 105, 40, 70, 100),
('#242', 'Blissey', '1.5', '46.8', 0, NULL, 'Pokémon Felicità', '3.90', 140, 255, 10, 10, 75, 135, 55),
('#243', 'Raikou', '1.9', '178.0', 7, NULL, 'Pokémon Tuono', '0.40', 35, 90, 85, 75, 115, 100, 115),
('#244', 'Entei', '2.1', '198.0', 1, NULL, 'Pokémon Vulcano', '0.40', 35, 115, 115, 85, 90, 75, 100),
('#245', 'Suicune', '2.0', '187.0', 3, NULL, 'Pokémon Aurora', '0.40', 35, 100, 75, 115, 90, 115, 85),
('#246', 'Lavitar', '0.6', '72.0', 10, 8, 'Pokémon Peldisasso', '5.90', 35, 50, 64, 50, 45, 50, 41),
('#247', 'Pupitar', '1.2', '152.0', 10, 8, 'Pokémon Guscioduro', '5.90', 35, 70, 84, 70, 65, 70, 51),
('#248', 'Tyranitar', '2.0', '202.0', 10, 15, 'Pokémon Armatura', '5.90', 35, 100, 134, 110, 95, 100, 61),
('#249', 'Lugia', '5.2', '216.0', 9, 4, 'Pokémon Immersione', '0.40', 0, 106, 90, 130, 90, 154, 110),
('#250', 'Ho-Oh', '3.8', '199.0', 1, 4, 'Pokémon Arcobaleno', '0.40', 0, 106, 130, 90, 110, 154, 90),
('#251', 'Celebi', '0.6', '5.0', 9, 5, 'Pokémon Tempovia', '5.90', 100, 100, 100, 100, 100, 100, 100),
('#252', 'Treecko', '0.5', '5.0', 5, NULL, 'Pokémon Legnogeco', '5.90', 70, 40, 45, 35, 65, 55, 70),
('#253', 'Grovyle', '0.9', '21.6', 5, NULL, 'Pokémon Legnogeco', '5.90', 70, 50, 65, 45, 85, 65, 95),
('#254', 'Sceptile', '1.7', '52.2', 5, NULL, 'Pokémon Foresta', '5.90', 70, 70, 85, 65, 105, 85, 120),
('#255', 'Torchic', '0.4', '2.5', 1, NULL, 'Pokémon Pulcino', '5.90', 70, 45, 60, 40, 70, 50, 45),
('#256', 'Combusken', '0.9', '19.5', 1, 2, 'Pokémon Rampollo', '5.90', 70, 60, 85, 60, 85, 60, 55),
('#257', 'Blaziken', '1.9', '52.0', 1, 2, 'Pokémon Vampe', '5.90', 70, 80, 120, 70, 110, 70, 80),
('#258', 'Mudkip', '0.4', '7.6', 3, NULL, 'Pokémon Fango Pesce', '5.90', 70, 50, 70, 50, 50, 50, 40),
('#259', 'Marshtomp', '0.7', '28.0', 3, 8, 'Pokémon Fango Pesce', '5.90', 70, 70, 85, 70, 60, 70, 50),
('#260', 'Swampert', '1.5', '81.9', 3, 8, 'Pokémon Fango Pesce', '5.90', 70, 100, 110, 90, 85, 90, 60),
('#261', 'Poochyena', '0.5', '13.6', 15, NULL, 'Pokémon Morso', '33.30', 70, 35, 55, 35, 30, 30, 35),
('#262', 'Mightyena', '1.0', '37.0', 15, NULL, 'Pokémon Morso', '16.60', 70, 70, 90, 70, 60, 60, 70),
('#263', 'Zigzagoon', '0.4', '17.5', 0, NULL, 'Pokémon Procione', '33.30', 70, 38, 30, 41, 30, 41, 60),
('#264', 'Linoone', '0.5', '32.5', 0, NULL, 'Pokémon Sfrecciante', '11.80', 70, 78, 70, 61, 50, 61, 100),
('#265', 'Wurmple', '0.3', '3.6', 12, NULL, 'Pokémon Baco', '33.30', 70, 45, 45, 35, 20, 30, 20),
('#266', 'Silcoon', '0.6', '10.0', 12, NULL, 'Pokémon Bozzolo', '15.70', 70, 50, 35, 55, 25, 25, 15),
('#267', 'Beautifly', '1.0', '28.4', 12, 4, 'Pokémon Farfalla', '5.90', 70, 60, 70, 50, 100, 50, 65),
('#268', 'Cascoon', '0.7', '11.5', 12, NULL, 'Pokémon Bozzolo', '15.70', 70, 50, 35, 55, 25, 25, 15),
('#269', 'Dustox', '1.2', '31.6', 12, 6, 'Pokémon Velentarma', '5.90', 70, 60, 50, 70, 50, 90, 65),
('#270', 'Lotad', '0.5', '2.6', 3, 5, 'Pokémon Alga', '33.30', 70, 40, 30, 30, 40, 50, 30),
('#271', 'Lombre', '1.2', '32.5', 3, 5, 'Pokémon Giocoso', '15.70', 70, 60, 50, 50, 60, 70, 50),
('#272', 'Ludicolo', '1.5', '55.5', 3, 5, 'Pokémon Spensierato', '5.90', 70, 80, 70, 70, 90, 100, 70),
('#273', 'Seedot', '0.5', '4.0', 3, NULL, 'Pokémon Ghianda', '33.30', 70, 40, 40, 50, 30, 30, 30),
('#274', 'Nuzleaf', '1.0', '28.0', 3, 15, 'Pokémon Scaltro', '15.70', 70, 70, 70, 40, 60, 40, 60),
('#275', 'Shiftry', '1.3', '59.6', 3, 15, 'Pokémon Burbero', '5.90', 70, 90, 100, 60, 90, 60, 80),
('#276', 'Taillow', '0.3', '2.3', 0, 4, 'Pokémon Rondine', '26.10', 70, 40, 55, 30, 30, 30, 85),
('#277', 'Swellow', '0.7', '19.8', 0, 4, 'Pokémon Rondine', '5.90', 70, 60, 85, 60, 75, 50, 125),
('#278', 'Wingull', '0.6', '9.5', 3, 4, 'Pokémon Gabbiano', '24.80', 70, 40, 30, 30, 55, 30, 85),
('#279', 'Pelipper', '1.2', '28.0', 3, 4, 'Pokémon Alacquatico', '5.90', 70, 60, 50, 100, 95, 70, 65),
('#280', 'Ralts', '0.4', '6.6', 9, 17, 'Pokémon Sensazione', '30.70', 35, 28, 25, 25, 45, 35, 40),
('#281', 'Kirlia', '0.8', '20.2', 9, 17, 'Pokémon Emozione', '15.70', 35, 38, 35, 35, 65, 55, 50),
('#282', 'Gardevoir', '1.6', '48.4', 9, 17, 'Pokémon Abbraccio', '5.90', 35, 68, 65, 65, 125, 115, 80),
('#283', 'Surskit', '0.5', '1.7', 12, 3, 'Pokémon Sfiorapozze', '26.10', 70, 40, 30, 32, 50, 52, 65),
('#284', 'Masquerain', '0.8', '3.6', 12, 4, 'Pokémon Occhi', '9.80', 70, 70, 60, 62, 100, 82, 80),
('#285', 'Shroomish', '0.4', '4.5', 5, NULL, 'Pokémon Fungo', '33.30', 70, 60, 40, 60, 40, 60, 35),
('#286', 'Breloom', '1.2', '39.2', 5, 2, 'Pokémon Fungo', '11.80', 70, 60, 130, 80, 60, 60, 70),
('#287', 'Slakoth', '0.8', '24.0', 0, NULL, 'Pokémon Ozioso', '33.30', 70, 60, 60, 60, 35, 35, 30),
('#288', 'Vigoroth', '1.4', '46.5', 0, NULL, 'Pokémon Indocile', '15.70', 70, 80, 80, 80, 55, 55, 90),
('#289', 'Slaking', '2.0', '130.5', 0, NULL, 'Pokémon Pigrizia', '5.90', 70, 150, 160, 100, 95, 65, 100),
('#290', 'Nincada', '0.5', '5.5', 12, 8, 'Pokémon Novizio', '33.30', 70, 31, 45, 90, 30, 30, 40),
('#291', 'Ninjask', '0.8', '12.0', 12, 4, 'Pokémon Ninja', '15.70', 70, 61, 90, 45, 50, 50, 160),
('#292', 'Shedinja', '0.8', '1.2', 12, 14, 'Pokémon Cambiapelle', '5.90', 70, 1, 90, 45, 30, 30, 40),
('#293', 'Whismur', '0.6', '16.3', 0, NULL, 'Pokémon Sussurro', '24.80', 70, 64, 51, 23, 51, 23, 28),
('#294', 'Loudred', '1.0', '40.5', 0, NULL, 'Pokémon Vocione', '15.70', 70, 84, 71, 43, 71, 43, 48),
('#295', 'Exploud', '1.5', '84.0', 0, NULL, 'Pokémon Fragore', '5.90', 70, 104, 91, 63, 91, 73, 68),
('#296', 'Makuhita', '1.0', '86.4', 2, NULL, 'Pokémon Coraggio', '23.50', 70, 72, 60, 30, 20, 30, 25),
('#297', 'Hariyama', '2.3', '253.8', 2, NULL, 'Pokémon Sberletese', '26.10', 70, 144, 120, 60, 40, 60, 50),
('#298', 'Azurill', '0.2', '2.0', 0, 17, 'Pokémon Pois', '19.60', 70, 50, 20, 40, 20, 40, 20),
('#299', 'Nosepass', '1.0', '97.0', 10, NULL, 'Pokémon Bussola', '33.30', 70, 30, 45, 135, 45, 90, 30),
('#300', 'Skitty', '0.6', '11.0', 0, NULL, 'Pokémon Micio', '33.30', 70, 50, 45, 45, 35, 35, 50),
('#301', 'Delcatty', '1.1', '32.6', 0, NULL, 'Pokémon Finezza', '7.80', 70, 70, 65, 65, 55, 55, 90),
('#302', 'Sableye', '0.5', '11.0', 15, 14, 'Pokémon Oscurità', '5.90', 35, 50, 75, 75, 65, 65, 50),
('#303', 'Mawile', '0.6', '11.5', 16, 17, 'Pokémon Inganno', '5.90', 70, 50, 85, 85, 55, 55, 50),
('#304', 'Aron', '0.4', '60.0', 16, 10, 'Pokémon Corazza', '23.50', 35, 50, 70, 100, 40, 40, 30),
('#305', 'Lairon', '0.9', '120.0', 16, 10, 'Pokémon Corazza', '11.80', 35, 60, 90, 140, 50, 50, 40),
('#306', 'Aggron', '2.1', '360.0', 16, 10, 'Pokémon Corazza', '5.90', 35, 70, 110, 180, 60, 60, 50),
('#307', 'Meditite', '0.6', '11.2', 2, 9, 'Pokémon Meditazione', '23.50', 70, 30, 40, 55, 40, 55, 60),
('#308', 'Medicham', '1.3', '31.5', 2, 9, 'Pokémon Meditazione', '11.80', 70, 60, 60, 75, 60, 75, 80),
('#309', 'Electrike', '0.6', '15.2', 7, NULL, 'Pokémon Lampo', '15.70', 70, 40, 45, 40, 65, 40, 65),
('#310', 'Manectric', '1.5', '40.2', 7, NULL, 'Pokémon Scarica', '5.90', 70, 70, 75, 60, 105, 60, 105),
('#311', 'Plusle', '0.4', '4.2', 7, NULL, 'Pokémon Incitamento', '26.10', 70, 60, 50, 40, 85, 75, 95),
('#312', 'Minum', '0.4', '4.2', 7, NULL, 'Pokémon Incitamento', '26.10', 70, 60, 40, 50, 75, 85, 95),
('#313', 'Volbeat', '0.7', '17.7', 12, NULL, 'Pokémon Lucciola', '19.60', 70, 65, 73, 75, 47, 85, 85),
('#314', 'Illumise', '0.6', '17.7', 12, NULL, 'Pokémon Lucciola', '19.60', 70, 65, 47, 75, 73, 85, 85),
('#315', 'Roselia', '0.3', '2.0', 5, 6, 'Pokémon Spina', '19.60', 70, 50, 60, 45, 100, 80, 65),
('#316', 'Gulpin', '0.4', '10.3', 6, NULL, 'Pokémon Stomaco', '29.40', 70, 70, 43, 53, 43, 53, 40),
('#317', 'Swalot', '1.7', '80.0', 6, NULL, 'Pokémon Velenosacco', '9.80', 70, 100, 73, 83, 73, 83, 55),
('#318', 'Carvanha', '0.8', '20.8', 3, 15, 'Pokémon Feroce', '29.50', 35, 45, 90, 20, 65, 20, 65),
('#319', 'Sharpedo', '1.8', '88.8', 3, 15, 'Pokémon Brutale', '7.80', 35, 70, 120, 40, 95, 40, 95),
('#320', 'Wailmer', '2.0', '130.0', 3, NULL, 'Pokémon Balenottero', '16.30', 70, 130, 70, 35, 70, 35, 60),
('#321', 'Wailord', '14.5', '398.0', 3, NULL, 'Pokémon Megabalena', '7.80', 70, 170, 90, 45, 90, 45, 60),
('#322', 'Numel', '0.7', '24.0', 1, 8, 'Pokémon Torpore', '33.30', 70, 60, 60, 40, 65, 45, 35),
('#323', 'Camerupt', '1.9', '220.0', 1, 8, 'Pokémon Eruzione', '19.60', 70, 70, 100, 70, 105, 75, 40),
('#324', 'Torkoal', '0.5', '80.4', 1, NULL, 'Pokémon Carbone', '11.80', 70, 70, 85, 140, 85, 70, 20),
('#325', 'Spoink', '0.7', '39.6', 9, NULL, 'Pokémon Molla', '33.30', 70, 60, 25, 35, 70, 80, 60),
('#326', 'Grumpig', '0.9', '71.5', 9, NULL, 'Pokémon Raggiro', '7.80', 70, 80, 45, 65, 90, 110, 80),
('#327', 'Spinda', '1.1', '5.0', 0, NULL, 'Pokémon Macchipanda', '33.30', 70, 60, 60, 60, 60, 60, 60),
('#328', 'Trapinch', '0.7', '15.0', 8, NULL, 'Pokémon Trappola', '33.30', 70, 45, 100, 45, 45, 45, 10),
('#329', 'Vibrava', '1.1', '15.3', 8, 13, 'Pokémon Vibrazione', '15.70', 70, 50, 70, 50, 50, 50, 70),
('#330', 'Flygon', '2.0', '82.0', 8, 13, 'Pokémon Magico', '5.90', 70, 80, 100, 80, 80, 80, 100),
('#331', 'Cacnea', '0.4', '51.3', 5, NULL, 'Pokémon Cactus', '24.80', 35, 50, 85, 40, 85, 40, 35),
('#332', 'Cacturne', '1.3', '77.4', 5, 15, 'Pokémon Spavento', '7.80', 35, 70, 115, 60, 115, 60, 55),
('#333', 'Swablu', '0.4', '1.2', 0, 4, 'Pokémon Alidicotone', '33.30', 70, 45, 40, 60, 40, 75, 50),
('#334', 'Altaria', '1.1', '20.6', 13, 4, 'Pokémon Canterino', '5.90', 70, 75, 70, 90, 70, 105, 80),
('#335', 'Zangoose', '1.3', '40.3', 0, NULL, 'Pokémon Furogatto', '11.80', 70, 73, 115, 60, 60, 60, 90),
('#336', 'Seviper', '2.7', '52.5', 6, NULL, 'Pokémon Zannaserpe', '11.80', 70, 73, 100, 60, 100, 60, 65),
('#337', 'Lunatone', '1.0', '168.0', 10, 9, 'Pokémon Meteorite', '5.90', 70, 90, 55, 65, 95, 85, 70),
('#338', 'Solrock', '1.2', '154.0', 10, 9, 'Pokémon Meteorite', '5.90', 70, 90, 95, 85, 55, 65, 70),
('#339', 'Barboach', '0.4', '1.9', 3, 8, 'Pokémon Baffetti', '24.80', 70, 50, 48, 43, 46, 41, 60),
('#340', 'Whiscash', '0.9', '23.6', 3, 8, 'Pokémon Baffetti', '9.80', 70, 110, 78, 73, 76, 71, 60),
('#341', 'Corphish', '0.6', '11.5', 3, NULL, 'Pokémon Birbone', '26.80', 70, 43, 80, 65, 50, 35, 35),
('#342', 'Crawdaunt', '1.1', '32.8', 3, 15, 'Pokémon Canaglia', '20.30', 70, 63, 120, 85, 90, 55, 55),
('#343', 'Baltoy', '0.5', '21.5', 8, 9, 'Pokémon Argilla', '33.30', 70, 40, 40, 55, 40, 70, 55),
('#344', 'Claydol', '1.5', '108.0', 8, 9, 'Pokémon Argilla', '11.80', 70, 60, 70, 105, 70, 120, 75),
('#345', 'Lileep', '1.0', '23.8', 10, 5, 'Pokémon Fiordimare', '5.90', 70, 66, 41, 77, 61, 87, 23),
('#346', 'Cradily', '1.5', '60.4', 10, 5, 'Pokémon Lepade', '5.90', 70, 86, 81, 97, 81, 107, 43),
('#347', 'Anorith', '0.7', '12.5', 10, 12, 'Pokémon Primaceo', '5.90', 70, 45, 95, 50, 40, 50, 75),
('#348', 'Armaldo', '1.5', '68.2', 10, 12, 'Pokémon Piastre', '5.90', 70, 75, 125, 100, 70, 80, 45),
('#349', 'Feebas', '0.6', '7.4', 3, NULL, 'Pokémon Pesce', '33.30', 70, 20, 15, 20, 10, 55, 80),
('#350', 'Milotic', '6.2', '162.0', 3, NULL, 'Pokémon Tenerezza', '7.80', 70, 95, 60, 79, 100, 125, 81),
('#351', 'Castform', '0.3', '0.8', 0, NULL, 'Pokémon Meteo', '5.90', 70, 70, 70, 70, 70, 70, 70),
('#352', 'Kecleon', '1.0', '22.0', 0, NULL, 'Pokémon Mutacolore', '26.10', 70, 60, 90, 70, 60, 120, 40),
('#353', 'Shuppet', '0.6', '2.3', 14, NULL, 'Pokémon Pupazzo', '29.40', 35, 44, 75, 35, 63, 33, 45),
('#354', 'Banette', '1.1', '12.5', 14, NULL, 'Pokémon Marionetta', '5.90', 35, 64, 115, 65, 83, 63, 65),
('#355', 'Duskull', '0.8', '15.0', 14, NULL, 'Pokémon Requiem', '24.80', 35, 20, 40, 90, 30, 90, 25),
('#356', 'Dusclops', '1.6', '30.6', 14, NULL, 'Pokémon Ipnosguardo', '11.80', 35, 40, 70, 130, 60, 130, 25),
('#357', 'Tropius', '2.0', '100.0', 5, 4, 'Pokémon Frutto', '26.10', 70, 99, 68, 83, 72, 87, 51),
('#358', 'Chimecho', '0.6', '1.0', 9, NULL, 'Pokémon Vencampana', '5.90', 70, 75, 50, 80, 95, 90, 65),
('#359', 'Absol', '1.2', '47.0', 15, NULL, 'Pokémon Catastrofe', '3.90', 35, 65, 130, 60, 75, 60, 75),
('#360', 'Wynaut', '0.6', '14.0', 9, NULL, 'Pokémon Brillante', '16.30', 70, 95, 23, 48, 23, 48, 23),
('#361', 'Snorunt', '0.7', '16.8', 11, NULL, 'Pokémon Cappelneve', '24.80', 70, 50, 50, 50, 50, 50, 50),
('#362', 'Glalie', '1.5', '256.5', 11, NULL, 'Pokémon Tuttomuso', '9.80', 70, 80, 80, 80, 80, 80, 80),
('#363', 'Spheal', '0.8', '39.5', 11, 3, 'Pokémon Rotolante', '33.30', 70, 70, 40, 50, 55, 50, 25),
('#364', 'Sealeo', '1.1', '87.6', 11, 3, 'Pokémon Rotapalla', '15.70', 70, 90, 60, 70, 75, 70, 45),
('#365', 'Walrein', '1.4', '150.6', 11, 3, 'Pokémon Spaccagelo', '5.90', 70, 110, 80, 90, 95, 90, 65),
('#366', 'Clamperl', '0.4', '52.5', 3, NULL, 'Pokémon Bivalve', '33.30', 70, 35, 64, 85, 74, 55, 32),
('#367', 'Huntail', '1.7', '27.0', 3, NULL, 'Pokémon Abissi', '7.80', 70, 55, 104, 105, 94, 75, 52),
('#368', 'Gorebyss', '1.8', '22.6', 3, NULL, 'Pokémon Sudmarino', '7.80', 70, 55, 84, 105, 114, 75, 52),
('#369', 'Relicanth', '1.0', '23.4', 3, 10, 'Pokémon Longevità', '3.30', 70, 100, 90, 130, 45, 65, 55),
('#370', 'Luvdisc', '0.6', '8.7', 3, NULL, 'Pokémon Rendezvous', '29.40', 70, 43, 30, 55, 40, 65, 97),
('#371', 'Bagon', '0.6', '42.1', 13, NULL, 'Pokémon Rocciotesta', '5.90', 35, 45, 75, 60, 40, 30, 50),
('#372', 'Shelgon', '1.1', '110.5', 13, NULL, 'Pokémon Resistenza', '5.90', 35, 65, 95, 100, 60, 50, 50),
('#373', 'Salamence', '1.5', '102.6', 13, 4, 'Pokémon Drago', '5.90', 35, 95, 135, 80, 110, 80, 100),
('#374', 'Beldum', '0.6', '95.2', 16, 9, 'Pokémon Ferrosfera', '0.40', 35, 40, 55, 80, 35, 60, 30),
('#375', 'Metang', '1.2', '202.5', 16, 9, 'Pokémon Ferrunghia', '0.40', 35, 60, 75, 100, 55, 80, 50),
('#376', 'Metagross', '1.6', '550.0', 16, 9, 'Pokémon Ferrarto', '0.40', 35, 80, 135, 130, 95, 90, 70),
('#377', 'Regirock', '1.7', '230.0', 10, NULL, 'Pokémon Picco', '0.40', 35, 80, 100, 200, 50, 100, 50),
('#378', 'Regice', '1.8', '175.0', 11, NULL, 'Pokémon Iceberg', '0.40', 35, 80, 50, 100, 100, 200, 50),
('#379', 'Registeel', '1.9', '205.0', 16, NULL, 'Pokémon Ferro', '0.40', 35, 80, 75, 150, 75, 150, 50),
('#380', 'Latias', '1.4', '40.0', 13, 9, 'Pokémon Eone', '0.40', 90, 80, 80, 90, 110, 130, 110),
('#381', 'Latios', '2.0', '60.0', 13, 9, 'Pokémon Eone', '0.40', 90, 80, 90, 80, 130, 110, 110),
('#382', 'Kyogre', '4.5', '352.0', 3, NULL, 'Pokémon Oceano', '0.40', 0, 100, 100, 90, 150, 140, 90),
('#383', 'Groudon', '3.5', '950.0', 8, NULL, 'Pokémon Continente', '0.40', 0, 100, 150, 140, 100, 90, 90),
('#384', 'Rayquaza', '7.0', '206.5', 13, 4, 'Pokémon Stratosfera', '0.40', 0, 105, 150, 90, 150, 90, 95),
('#385', 'Jirachi', '0.3', '1.1', 16, 9, 'Pokémon Desiderio', '0.40', 100, 100, 100, 100, 100, 100, 100),
('#386', 'Deoxys', '1.7', '60.8', 9, NULL, 'Pokémon DNA', '0.40', 0, 50, 150, 50, 150, 50, 150),
('#387', 'Turtwig', '0.4', '10.2', 5, NULL, 'Pokémon Fogliolina', '5.90', 70, 55, 68, 64, 45, 55, 31),
('#388', 'Grotle', '1.1', '97.0', 5, NULL, 'Pokémon Boschetto', '5.90', 70, 75, 89, 85, 55, 65, 36),
('#389', 'Torterra', '2.2', '310.0', 5, 8, 'Pokémon Continente', '5.90', 70, 95, 109, 105, 75, 85, 56),
('#390', 'Chimchar', '0.5', '6.2', 1, NULL, 'Pokémon Scimpanzé', '5.90', 70, 44, 58, 44, 58, 44, 61),
('#391', 'Monferno', '0.9', '22.0', 1, 2, 'Pokémon Briccone', '5.90', 70, 64, 78, 52, 78, 52, 81),
('#392', 'Infernape', '1.2', '55.0', 1, 2, 'Pokémon Fiamma', '5.90', 70, 76, 104, 71, 104, 71, 108),
('#393', 'Piplup', '0.4', '5.2', 3, NULL, 'Pokémon Pinguino', '5.90', 70, 53, 51, 53, 61, 56, 40),
('#394', 'Prinplup', '0.8', '23.0', 3, NULL, 'Pokémon Pinguino', '5.90', 70, 64, 66, 68, 81, 76, 50),
('#395', 'Empoleon', '1.7', '84.5', 3, 16, 'Pokémon Imperatore', '5.90', 70, 84, 86, 88, 111, 101, 60),
('#396', 'Starly', '0.3', '2.0', 0, 4, 'Pokémon Storno', '33.30', 70, 40, 55, 30, 30, 30, 60),
('#397', 'Staravia', '0.6', '15.5', 0, 4, 'Pokémon Storno', '15.70', 70, 55, 75, 50, 40, 40, 80),
('#398', 'Staraptor', '1.2', '24.9', 0, 4, 'Pokémon Rapace', '5.90', 70, 85, 120, 70, 50, 60, 100),
('#399', 'Bidoof', '0.5', '20.0', 0, NULL, 'Pokémon Topaffuto', '33.30', 70, 59, 45, 40, 35, 40, 31),
('#400', 'Bibarel', '1.0', '31.5', 0, 3, 'Pokémon Castoro', '16.60', 70, 79, 85, 60, 55, 60, 71),
('#401', 'Kricketot', '0.3', '2.2', 12, NULL, 'Pokémon Grillo', '33.30', 70, 37, 25, 41, 25, 41, 25),
('#402', 'Kricketune', '1.0', '25.5', 12, NULL, 'Pokémon Grillo', '5.90', 70, 77, 85, 51, 55, 51, 65),
('#403', 'Shinx', '0.5', '9.5', 7, NULL, 'Pokémon Baleno', '30.70', 70, 45, 65, 34, 40, 34, 45);

-- --------------------------------------------------------

--
-- Struttura della tabella `squadre`
--

CREATE TABLE `squadre` (
  `NomeSquadra` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Vittorie` smallint(6) NOT NULL DEFAULT '0',
  `Sconfitte` smallint(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `squadre`
--

INSERT INTO `squadre` (`NomeSquadra`, `Vittorie`, `Sconfitte`) VALUES
('Squadra1', 15, 12),
('Squadra2', 7, 9),
('Squadra3', 120, 57),
('Squadra4', 1, 8);

-- --------------------------------------------------------

--
-- Struttura della tabella `strumenti`
--

CREATE TABLE `strumenti` (
  `IdStrumento` smallint(6) NOT NULL,
  `NomeStrum` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DescrStrum` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TipoStrum` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `strumenti`
--

INSERT INTO `strumenti` (`IdStrumento`, `NomeStrum`, `DescrStrum`, `TipoStrum`) VALUES
(1, 'Antidoto', 'Usato per curare l''avvelenamento', 'Rimedio'),
(2, 'Antiparalisi', 'Usato per curare la paralisi', 'Rimedio'),
(3, 'Sveglia', 'Si usa per svegliare un Pokémon', 'Rimedio'),
(4, 'Antiscottatura', 'Usato per curare le scottature', 'Rimedio'),
(5, 'Antigelo', 'Usato per scongelare un Pokémon congelato', 'Rimedio'),
(6, 'Cura totale', 'Cura avvelenamento, paralisi, sonno, scottatura, confusione o congelamento', 'Rimedio'),
(7, 'Ricarica totale', 'Ripristina i PS massimi e cura ogni problema di stato non volatile; a partire dalla seconda generazione cura anche la confusione', 'Rimedio'),
(8, 'Lavottino', 'Usato per curare avvelenamento, paralisi, sonno, scottatura, confusione o congelamento', 'Rimedio'),
(9, 'Dolce Gateau', 'Usato per curare avvelenamento, paralisi, sonno, scottatura, confusione o congelamento.', 'Rimedio'),
(10, 'Conostropoli', 'Usato per curare avvelenamento, paralisi, sonno, scottatura, confusione e congelamento', 'Rimedio'),
(11, 'Cuordileone', 'Chi la usa si tira su di morale, aumentando il proprio Attacco e l''Attacco Speciale', 'MT'),
(12, 'Psicoshock', 'Chi la usa attacca il bersaglio facendo materializzare un misterioso raggio psichico che provoca danni fisici', 'MT'),
(13, 'Calmamente', 'Chi la usa, meditando, placa il proprio spirito per aumentare l''Attacco Speciale e la Difesa Speciale', 'MT'),
(14, 'Boato', 'Il bersaglio è costretto a lasciare il campo e viene sostituito. Mette fine alle lotte contro Pokémon selvatici', 'MT'),
(15, 'Grandine', 'Chi la usa causa una grandinata che dura cinque turni. Danneggia tutti i Pokémon tranne quelli di tipo Ghiaccio', 'MT'),
(16, 'Granfisico', 'Chi la usa tende i muscoli per gonfiare il corpo, aumentando Difesa e Attacco', 'MT'),
(17, 'Velenoshock', 'Lancia uno speciale liquido tossico sul bersaglio. Se questi è avvelenato, il danno provocato raddoppia', 'MT'),
(18, 'Introforza', 'Mossa singolare che cambia tipo e potenza a seconda del Pokémon che la usa', 'MT'),
(19, 'Giornodisole', 'Chi la usa intensifica i raggi solari per cinque turni, potenziando le mosse di tipo Fuoco', 'MT'),
(20, 'Baccaliegia', 'Cura Paralisi', 'Bacca'),
(21, 'Baccastagna', 'Cura Sonno', 'Bacca'),
(22, 'Baccapesca', 'Cura Avvelenamento', 'Bacca'),
(23, 'Baccafrago', 'Cura Scottatura', 'Bacca'),
(24, 'Baccaperina', 'Cura Congelamento', 'Bacca'),
(25, 'baccamela', 'Restituisce 10 PP', 'Bacca'),
(26, 'Baccarancia', '	Restituisce 10 PS', 'Bacca'),
(27, 'Baccaki', 'Cura Confusione', 'Bacca'),
(28, 'Baccaprugna', 'Cura qualsiasi problema di stato', 'Bacca'),
(29, 'Baccacedro', 'Restituisce 25% PS', 'Bacca'),
(30, 'Baccafico', 'Restituisce 50% PS, confonde i Pokémon che non amano il cibo piccante', 'Bacca'),
(31, 'Baccakiwi', 'Restituisce 50% PS, confonde i Pokémon che non amano il cibo secco', 'Bacca'),
(32, 'Baccamango', 'Restituisce 50% PS, confonde i Pokémon che non amano il cibo dolce', 'Bacca'),
(33, 'Baccaguava', 'Restituisce 50% PS, confonde i Pokémon che non amano il cibo amaro', 'Bacca'),
(34, 'Baccapaia', 'Restituisce 50% PS, confonde i Pokémon che non amano il cibo aspro', 'Bacca'),
(35, 'Baccamora', 'Nessuno', 'Bacca'),
(36, 'Baccananas', 'Nessuno', 'Bacca'),
(37, 'Baccagrana', 'Diminuisce i PA relativi ai PS, aumenta l''affetto', 'Bacca'),
(38, 'Bendascelta', 'Aumenta lAttacco del 50%, ma non consente di usare altre mosse dopo la prima', 'Base'),
(39, 'Lentiscelta', 'Aumenta l''Attacco Speciale del 50%, ma non consente di usare altre mosse dopo la prima', 'Base'),
(40, 'Stolascelta', 'Aumenta la Velocità del 50%, ma non consente di usare altre mosse dopo la prima', 'Base'),
(41, 'Erbachiara', 'Impedisce ogni modifica negativa delle statistiche di chi la tiene. Si consuma dopo l''uso', 'Base'),
(42, 'Mentalerba', ' Previene l''infatuazione e rimuove gli effetti di Provocazione, Inibitore, Ripeti, Attaccalite e Corpofunesto. Si consuma dopo l''uso', 'Base'),
(43, 'Vigorerba', 'Permette a chi la usa di omettere il primo turno di preparazione di determinate mosse. Si consuma dopo l''uso. Funziona su mosse come Solarraggio, Capo', 'Base'),
(44, 'Avanzi', 'Ripristina 1/16 (arrotondato per difetto) dei PS massimi del Pokémon che lo tiene, ad ogni turno', 'Base'),
(45, 'Conchinella', 'Ripristina una piccola quantità di PS se il Pokémon che lo tiene infligge danno (1/8 del danno inflitto)', 'Base'),
(46, 'Granradice', 'Il numero dei PS rubati da mosse che li sottraggono all''avversario sono aumentati del 30%', 'Base'),
(47, 'Abilcintura', 'Aumenta la potenza delle mosse superefficaci del 20%', 'Base'),
(48, 'Assorbisfera', 'Aumenta la potenza delle mosse del 30%, ma al costo del 10% dei PS massimi ogni volta che chi la tiene usa un attacco ed infligge danno. L''Assorbisfer', 'Base'),
(49, 'Corpetto assalto', 'Quando tenuto da un Pokémon, questo strumento incrementa la Difesa Speciale del 50%, ma il Pokémon non può utilizzare mosse di stato', 'Base'),
(50, 'Elettroseme', 'Se chi lo tiene combatte su un terreno nello stato di Campo Elettrico, la sua Difesa aumenta di un livello', 'Base'),
(51, 'Erbaseme', 'Se chi lo tiene combatte su un terreno nello stato di Campo Erboso, la sua Difesa aumenta di un livello', 'Base'),
(52, 'Muscolbanda', 'Aumenta la potenza delle Mosse Fisiche del 10%', 'Base'),
(53, 'Nebbiaseme', 'Se chi lo tiene combatte su un terreno nello stato di Campo Nebbioso, la sua Difesa Speciale aumenta di un livello', 'Base'),
(54, 'Psicoseme', 'Se chi lo tiene combatte su un terreno nello stato di Campo Psichico, la sua Difesa Speciale aumenta di un livello', 'Base'),
(55, 'Focalnastro', 'Se chi lo tiene ha pieni PS prima di ricevere un colpo potenzialmente fatale, questo permette al Pokémon di sopravvivere all''attacco, lasciandolo con ', 'Base');

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo`
--

CREATE TABLE `tipo` (
  `IdTipo` smallint(6) NOT NULL,
  `NomeTipo` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `tipo`
--

INSERT INTO `tipo` (`IdTipo`, `NomeTipo`) VALUES
(16, 'Acciaio'),
(3, 'Acqua'),
(15, 'Buio'),
(12, 'Coleottero'),
(13, 'Drago'),
(7, 'Elettro'),
(5, 'Erba'),
(17, 'Folletto'),
(1, 'Fuoco'),
(11, 'Ghiaccio'),
(2, 'Lotta'),
(0, 'Normale'),
(9, 'Psico'),
(10, 'Roccia'),
(14, 'Spettro'),
(8, 'Terra'),
(6, 'Veleno'),
(4, 'Volante');

-- --------------------------------------------------------

--
-- Struttura della tabella `zonacattura`
--

CREATE TABLE `zonacattura` (
  `IdZona` smallint(6) NOT NULL,
  `NomeZona` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DescrZona` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Morfologia` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dump dei dati per la tabella `zonacattura`
--

INSERT INTO `zonacattura` (`IdZona`, `NomeZona`, `DescrZona`, `Morfologia`) VALUES
(0, 'Percorso 1', 'Percorso immerso nella natura che collega Lili e Hau''oli', 'Percorso'),
(1, 'Percorso 2', 'Percorso che conduce alla parte nord di Mele Mele. Tanti Allenatori si riuniscono qui per allenarsi', 'Percorso'),
(2, 'Percorso 3', 'Scosceso percorso di montagna costeggiato da pareti rocciose in cui vivono numerosi Pokémon alati', 'Percorso'),
(3, 'Percorso 4', 'Percorso ricco di vegetazione che collega Kantai e Ohana', 'Percorso'),
(4, 'Percorso 5', 'Percorso tortuoso e pieno di dislivelli piuttosto faticoso da percorrere', 'Percorso'),
(5, 'Percorso 6', 'Percorso rettilineo noto come "la retta via"', 'Percorso'),
(6, 'Percorso 7', 'Percorso che conduce al Parco Vulcano Wela da cui fuoriescono vapori torridi che fanno sudare profusamente', 'Percorso'),
(7, 'Percorso 8', 'Strada panoramica con una fantastica vista sul mare. Lo sfondo ideale per un appuntamento romantico!', 'Percorso'),
(8, 'Percorso 9', 'Breve percorso realizzato dai Diglett con le forze residue dopo aver scavato il Tunnel Diglett', 'Percorso'),
(9, 'Percorso 10', 'Percorso disseminato di tane di Pokémon che si riallaccia alla strada che porta in cima al Picco Hokulani', 'Percorso'),
(10, 'Percorso 11', 'Percorso immerso nella natura al limitare della città di Malie. Conduce a un accidentato sentiero di montagna', 'Percorso'),
(11, 'Percorso 12', 'Percorso accidentato costellato di sassi aguzzi che ostacolano il cammino', 'Percorso'),
(12, 'Percorso 13', 'Il luogo ideale per una piccola pausa prima di affrontare il Deserto Haina', 'Percorso'),
(13, 'Percorso 14', 'Piccola spiaggia appartata situata nel versante meno popolato di Ula Ula', 'Percorso'),
(14, 'Percorso 15', 'Articolato percorso acquatico situato nella parte occidentale di Ula Ula, attraversabile solo con l’aiuto dei Pokémon', 'Percorso'),
(15, 'Percorso 16', 'Breve percorso che ospita un Centro Pokémon, l’ideale per fare una pausa prima di attraversare il Prato Ula Ula', 'Percorso'),
(16, 'Percorso 17', 'La pioggia insistente mette addosso a chi attraversa questo percorso una vaga sensazione di inquietudine', 'Percorso'),
(17, 'Sentiero Mahalo', 'Sentiero di montagna che conduce a un tempio sacro. L’aria buona che vi si respira è un toccasana', 'Percorso'),
(18, 'Cimitero di Hau''oli', 'Qui riposano insieme esseri umani e Pokémon, secondo le usanze di Mele Mele', 'Edificio'),
(19, 'Orto delle Bacche', 'Orto allestito in un’area dal terreno soffice che costituisce l’orgoglio di Bacco Bacchini', 'Percorso'),
(20, 'Grotta Sottobosco', 'Grotta ricca di vegetazione inondata da una luce soffusa che la rende molto suggestiva', 'Grotta'),
(21, 'Prato Mele Mele', 'Prato disseminato di fiori gialli da cui si raccoglie un nettare molto amato dagli Oricorio', 'Percorso'),
(22, 'Grotta Pratomare', 'Grotta che collega il Prato Mele Mele alla Baia Kala’e. Vi si avverte pungente l’odore salmastro del mare', 'Grotta'),
(23, 'Baia Kala''e', 'Un piccolo angolo di paradiso considerato fra i 100 punti panoramici più belli di Alola', 'Percorso'),
(24, 'Collina Diecicarati', 'Collina formatasi in seguito all''eruzione di un vulcano sottomarino, famosa per la vasta caldera nelle sue profondità', 'Grotta'),
(25, 'Fattoria Ohana', 'Fattoria gestita da Pokémon ed esseri umani in stretta collaborazione', 'Edificio'),
(26, 'Collina Scrosciante', 'Le numerose cascate su vari livelli danno all''area l''aspetto di un campo terrazzato. Non c''è posto migliore per pescare', 'Percorso'),
(27, 'Mare di Mele Mele', 'Gremito di abitanti di Mele Mele, turisti e Pokémon durante tutto l''anno', 'Percorso'),
(28, 'Viale Royale', 'Ampio viale sviluppatosi attorno allo Stadio Royale che per le sue numerose strutture si può considerare una vera cittadina', 'Edificio'),
(29, 'Parco Vulcano Wela', 'Montagna desolata e accidentata sulla cui cima si svolge una delle prove', 'Percorso'),
(30, 'Giungla Ombrosa', 'Fitta e lussureggiante foresta pluviale tropicale dove si possono trovare ottimi ingredienti per cucinare', 'Percorso'),
(31, 'Tunnel Diglett', 'Tunnel realizzato molti anni fa grazie allo sforzo congiunto di Diglett ed esseri umani', 'Grotta'),
(32, 'Colle della Memoria', 'Luogo dedicato alla memoria di uomini e Pokémon, meta di visitatori provenienti da ogni angolo dell''arcipelago', 'Percorso'),
(33, 'Punta Akala', 'Area verdeggiante affacciata sul mare situata tra il Colle della Memoria e il Tempio della Vita', 'Percorso'),
(34, 'Tempio dedicato al Pokémo', 'Fitta e lussureggiante foresta pluviale tropicale dove si possono trovare ottimi ingredienti per cucinare', 'Edificio'),
(35, 'Resort Hanu Hanu', 'Il resort più grande e lussuoso di Alola. Tutto prenotato fino all''anno prossimo!', 'Edificio'),
(36, 'Spiaggia Hanu Hanu', 'Spiaggia annessa all''hotel del Resort Hanu Hanu dove si può guadagnare qualche soldo ributtando in mare i Pyukumuku', 'Percorso'),
(37, 'Æther Paradise', 'Struttura fluttuante che ospita i laboratori di ricerca della Fondazione Æther', 'Edificio'),
(38, 'Giardino di Malie', 'Vasto parco nel centro di Malie il cui grande lago, visto dall''alto, ricorda una forma familiare', 'Percorso'),
(100, 'Scambio', 'Scambiato da un altro allenatore', NULL),
(101, 'Uovo', 'Ottenuto tramite accoppiamento', NULL),
(102, 'Ultravarco', 'Dimensione distrorta', NULL);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `abilita`
--
ALTER TABLE `abilita`
  ADD PRIMARY KEY (`IdAbilita`),
  ADD UNIQUE KEY `NomeAbilita` (`NomeAbilita`),
  ADD KEY `Introduzione` (`Introduzione`);

--
-- Indici per le tabelle `apprendimento`
--
ALTER TABLE `apprendimento`
  ADD PRIMARY KEY (`IdMossa`,`IdSPokemon`),
  ADD KEY `IdSPokemon` (`IdSPokemon`);

--
-- Indici per le tabelle `composizione`
--
ALTER TABLE `composizione`
  ADD PRIMARY KEY (`Squadra`,`NickPokemon`),
  ADD KEY `NickPokemon` (`NickPokemon`);

--
-- Indici per le tabelle `conoscenza`
--
ALTER TABLE `conoscenza`
  ADD PRIMARY KEY (`CeNickname`,`IdMossa`),
  ADD KEY `IdMossa` (`IdMossa`);

--
-- Indici per le tabelle `efficacia`
--
ALTER TABLE `efficacia`
  ADD PRIMARY KEY (`Attaccante`,`Difensore`),
  ADD KEY `Difensore` (`Difensore`);

--
-- Indici per le tabelle `evoluzione`
--
ALTER TABLE `evoluzione`
  ADD PRIMARY KEY (`Evoluto`),
  ADD KEY `Evolvente` (`Evolvente`);

--
-- Indici per le tabelle `generazione`
--
ALTER TABLE `generazione`
  ADD PRIMARY KEY (`IdGen`);

--
-- Indici per le tabelle `mosse`
--
ALTER TABLE `mosse`
  ADD PRIMARY KEY (`IdMossa`),
  ADD UNIQUE KEY `NomeMossa` (`NomeMossa`),
  ADD KEY `TipoMossa` (`TipoMossa`);

--
-- Indici per le tabelle `natura`
--
ALTER TABLE `natura`
  ADD PRIMARY KEY (`IdNatura`),
  ADD UNIQUE KEY `NomeNatura` (`NomeNatura`);

--
-- Indici per le tabelle `pokemon`
--
ALTER TABLE `pokemon`
  ADD PRIMARY KEY (`Nickname`),
  ADD KEY `CeSpecie` (`CeSpecie`),
  ADD KEY `CeStrumento` (`CeStrumento`),
  ADD KEY `CeAbilita` (`CeAbilita`),
  ADD KEY `CeNatura` (`CeNatura`),
  ADD KEY `CeZonaCattura` (`CeZonaCattura`);

--
-- Indici per le tabelle `speciepokemon`
--
ALTER TABLE `speciepokemon`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Nome` (`Nome`),
  ADD KEY `Tipo1` (`Tipo1`),
  ADD KEY `Tipo2` (`Tipo2`);

--
-- Indici per le tabelle `squadre`
--
ALTER TABLE `squadre`
  ADD PRIMARY KEY (`NomeSquadra`);

--
-- Indici per le tabelle `strumenti`
--
ALTER TABLE `strumenti`
  ADD PRIMARY KEY (`IdStrumento`),
  ADD UNIQUE KEY `NomeStrum` (`NomeStrum`);

--
-- Indici per le tabelle `tipo`
--
ALTER TABLE `tipo`
  ADD PRIMARY KEY (`IdTipo`),
  ADD UNIQUE KEY `NomeTipo` (`NomeTipo`);

--
-- Indici per le tabelle `zonacattura`
--
ALTER TABLE `zonacattura`
  ADD PRIMARY KEY (`IdZona`),
  ADD UNIQUE KEY `NomeZona` (`NomeZona`,`DescrZona`);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `abilita`
--
ALTER TABLE `abilita`
  ADD CONSTRAINT `abilita_ibfk_1` FOREIGN KEY (`Introduzione`) REFERENCES `generazione` (`IdGen`);

--
-- Limiti per la tabella `apprendimento`
--
ALTER TABLE `apprendimento`
  ADD CONSTRAINT `apprendimento_ibfk_1` FOREIGN KEY (`IdMossa`) REFERENCES `mosse` (`IdMossa`),
  ADD CONSTRAINT `apprendimento_ibfk_2` FOREIGN KEY (`IdSPokemon`) REFERENCES `speciepokemon` (`Id`);

--
-- Limiti per la tabella `composizione`
--
ALTER TABLE `composizione`
  ADD CONSTRAINT `composizione_ibfk_1` FOREIGN KEY (`Squadra`) REFERENCES `squadre` (`NomeSquadra`),
  ADD CONSTRAINT `composizione_ibfk_2` FOREIGN KEY (`NickPokemon`) REFERENCES `pokemon` (`Nickname`);

--
-- Limiti per la tabella `conoscenza`
--
ALTER TABLE `conoscenza`
  ADD CONSTRAINT `conoscenza_ibfk_1` FOREIGN KEY (`CeNickname`) REFERENCES `pokemon` (`Nickname`),
  ADD CONSTRAINT `conoscenza_ibfk_2` FOREIGN KEY (`IdMossa`) REFERENCES `mosse` (`IdMossa`);

--
-- Limiti per la tabella `efficacia`
--
ALTER TABLE `efficacia`
  ADD CONSTRAINT `efficacia_ibfk_1` FOREIGN KEY (`Attaccante`) REFERENCES `tipo` (`IdTipo`),
  ADD CONSTRAINT `efficacia_ibfk_2` FOREIGN KEY (`Difensore`) REFERENCES `tipo` (`IdTipo`);

--
-- Limiti per la tabella `evoluzione`
--
ALTER TABLE `evoluzione`
  ADD CONSTRAINT `evoluzione_ibfk_1` FOREIGN KEY (`Evoluto`) REFERENCES `speciepokemon` (`Id`),
  ADD CONSTRAINT `evoluzione_ibfk_2` FOREIGN KEY (`Evolvente`) REFERENCES `speciepokemon` (`Id`);

--
-- Limiti per la tabella `mosse`
--
ALTER TABLE `mosse`
  ADD CONSTRAINT `mosse_ibfk_1` FOREIGN KEY (`TipoMossa`) REFERENCES `tipo` (`IdTipo`);

--
-- Limiti per la tabella `pokemon`
--
ALTER TABLE `pokemon`
  ADD CONSTRAINT `pokemon_ibfk_1` FOREIGN KEY (`CeSpecie`) REFERENCES `speciepokemon` (`Id`),
  ADD CONSTRAINT `pokemon_ibfk_2` FOREIGN KEY (`CeStrumento`) REFERENCES `strumenti` (`IdStrumento`),
  ADD CONSTRAINT `pokemon_ibfk_3` FOREIGN KEY (`CeAbilita`) REFERENCES `abilita` (`IdAbilita`),
  ADD CONSTRAINT `pokemon_ibfk_4` FOREIGN KEY (`CeNatura`) REFERENCES `natura` (`IdNatura`),
  ADD CONSTRAINT `pokemon_ibfk_5` FOREIGN KEY (`CeZonaCattura`) REFERENCES `zonacattura` (`IdZona`);

--
-- Limiti per la tabella `speciepokemon`
--
ALTER TABLE `speciepokemon`
  ADD CONSTRAINT `speciepokemon_ibfk_1` FOREIGN KEY (`Tipo1`) REFERENCES `tipo` (`IdTipo`),
  ADD CONSTRAINT `speciepokemon_ibfk_2` FOREIGN KEY (`Tipo2`) REFERENCES `tipo` (`IdTipo`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
