--CREATE DATABASE Pizzeria

CREATE TABLE Ingrediente(
	Codice_Ingrediente INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	Costo DECIMAL(4,2) NOT NULL,
	Scorte INT NOT NULL,
	CONSTRAINT PK_Ingrediente PRIMARY KEY (Codice_Ingrediente),
	CONSTRAINT UQ_NomeIngrediente UNIQUE(Nome),
	CONSTRAINT CK_Costo CHECK (Costo > 0),
	CONSTRAINT CK_Scorte CHECK (Scorte >= 0)
)

CREATE TABLE Pizza(
	Codice_Pizza INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	Prezzo DECIMAL(4,2) NOT NULL,
	CONSTRAINT PK_Pizza PRIMARY KEY (Codice_Pizza),
	CONSTRAINT UQ_NomePizza UNIQUE(Nome),
	CONSTRAINT CK_Prezzo CHECK(Prezzo > 0)
)

CREATE TABLE IngredientePizza(
	Codice_Ingrediente INT NOT NULL,
	Codice_Pizza INT NOT NULL,
	CONSTRAINT FK_Ingrediente FOREIGN KEY (Codice_Ingrediente)
		REFERENCES Ingrediente(Codice_Ingrediente),
	CONSTRAINT FK_Pizza FOREIGN KEY (Codice_Pizza)
		REFERENCES Pizza(Codice_Pizza),
	CONSTRAINT UQ_IngPizza UNIQUE (Codice_Ingrediente,Codice_Pizza)
)

CREATE INDEX RicercaPizzaNome
ON Pizza (Nome)

CREATE INDEX RicercaIngredienteCodice
ON Ingrediente (Codice_Ingrediente)

CREATE INDEX RicercaIngredienteNome
ON Ingrediente (Nome)


--INSERIMENTO VALORI

INSERT INTO Pizza VALUES
('Margherita',5),('Bufala',7),('Diavola',6),('Quattro stagioni',6.5),
('Porcini',7),('Dioniso',8),('Ortolana',8),('Patate e salsiccia',6),
('Pomodorini',6),('Quattro formaggi',7.5),('Caprese',7.5)

INSERT INTO Ingrediente VALUES 
('Pomodoro', 1.5,83),
('Mozzarella',1.23,120),
('Mozzarella di bufala',3.2,32),
('Spianata piccante',2.5,20),
('Funghi',3.21,60),
('Carciofi',3.82,14),
('Cotto',5.64,53),
('Olive',3.20,98),
('Funghi porcini',4.65,43),
('Stracchino',3.54,9),
('Speck',5.32,9),
('Rucola',0.4,12),
('Grana',9.54,20),
('Verdure di stagione',5.43,7),
('Patate',1.34,54),
('Salsiccia',5.43,6),
('Pomodorini',5.32,12),
('Ricotta',4,16),
('Provola',6.32,7),
('Gorgonzola',4,5),
('Pomodoro fresco',3,15),
('Basilico',0.5,20),
('Bresaola',4.87,19)



CREATE PROCEDURE AssociaIngredientePizza
@nomePizza VARCHAR(50),
@nomeIngrediente VARCHAR(50)
AS
BEGIN
	BEGIN TRY
		DECLARE @CodicePizza INT
		DECLARE @CodiceIngrediente INT

		SELECT @CodicePizza = p.Codice_Pizza
		FROM Pizza p
		WHERE p.Nome = @nomePizza

		SELECT @CodiceIngrediente = i.Codice_Ingrediente
		FROM Ingrediente i
		WHERE i.Nome = @nomeIngrediente

		INSERT INTO IngredientePizza values (@CodiceIngrediente,@CodicePizza)
	END TRY
	BEGIN CATCH
		SELECT ERROR_LINE(),ERROR_MESSAGE(), ERROR_SEVERITY()
	END CATCH
END



EXEC AssociaIngredientePizza 'Margherita','Pomodoro'
EXEC AssociaIngredientePizza 'Margherita','Mozzarella'
EXEC AssociaIngredientePizza 'Bufala','Pomodoro'
EXEC AssociaIngredientePizza 'Bufala','Mozzarella di bufala'
EXEC AssociaIngredientePizza 'Diavola','Pomodoro'
EXEC AssociaIngredientePizza 'Diavola','Mozzarella'
EXEC AssociaIngredientePizza 'Diavola','Spianata piccante'
EXEC AssociaIngredientePizza 'Quattro stagioni','Pomodoro'
EXEC AssociaIngredientePizza 'Quattro stagioni','Mozzarella'
EXEC AssociaIngredientePizza 'Quattro stagioni','Funghi'
EXEC AssociaIngredientePizza 'Quattro stagioni','Carciofi'
EXEC AssociaIngredientePizza 'Quattro stagioni','Cotto'
EXEC AssociaIngredientePizza 'Quattro stagioni','Olive'
EXEC AssociaIngredientePizza 'Porcini','Pomodoro'
EXEC AssociaIngredientePizza 'Porcini','Mozzarella'
EXEC AssociaIngredientePizza 'Porcini','Funghi porcini'
EXEC AssociaIngredientePizza 'Dioniso','Pomodoro'
EXEC AssociaIngredientePizza 'Dioniso','Mozzarella'
EXEC AssociaIngredientePizza 'Dioniso','Stracchino'
EXEC AssociaIngredientePizza 'Dioniso','Speck'
EXEC AssociaIngredientePizza 'Dioniso','Rucola'
EXEC AssociaIngredientePizza 'Dioniso','Grana'
EXEC AssociaIngredientePizza 'Ortolana','Pomodoro'
EXEC AssociaIngredientePizza 'Ortolana','Mozzarella'
EXEC AssociaIngredientePizza 'Ortolana','Verdure di stagione'
EXEC AssociaIngredientePizza 'Patate e salsiccia','Mozzarella'
EXEC AssociaIngredientePizza 'Patate e salsiccia','Patate'
EXEC AssociaIngredientePizza 'Patate e salsiccia','Salsiccia'
EXEC AssociaIngredientePizza 'Pomodorini','Mozzarella'
EXEC AssociaIngredientePizza 'Pomodorini','Pomodorini'
EXEC AssociaIngredientePizza 'Pomodorini','Ricotta'
EXEC AssociaIngredientePizza 'Quattro formaggi','Mozzarella'
EXEC AssociaIngredientePizza 'Quattro formaggi','Provola'
EXEC AssociaIngredientePizza 'Quattro formaggi','Gorgonzola'
EXEC AssociaIngredientePizza 'Quattro formaggi','Grana'
EXEC AssociaIngredientePizza 'Caprese','Mozzarella'
EXEC AssociaIngredientePizza 'Caprese','Pomodoro fresco'
EXEC AssociaIngredientePizza 'Caprese','Basilico'

SELECT * FROM Ingrediente






-- PROCEDURE





CREATE PROCEDURE InserisciPizza
@nome VARCHAR(50),
@prezzo decimal(4,2)
AS
BEGIN
	BEGIN TRY
		INSERT INTO Pizza VALUES (@nome,@prezzo)
	END TRY
	BEGIN CATCH
		SELECT ERROR_LINE(),ERROR_MESSAGE(),ERROR_SEVERITY()
	END CATCH
END

EXEC InserisciPizza 'Zeus',7.5

CREATE PROCEDURE AssegnaIngredientePizzaCodice
@codice_pizza int,
@codice_ingrediente int
AS
BEGIN
	BEGIN TRY
		INSERT INTO IngredientePizza VALUES (@codice_ingrediente,@codice_pizza)
	END TRY
	BEGIN CATCH
		SELECT ERROR_LINE(),ERROR_MESSAGE(),ERROR_SEVERITY()
	END CATCH
END

SELECT * FROM Ingrediente

exec AssegnaIngredientePizzaCodice 12,2
exec AssegnaIngredientePizzaCodice 12,23
exec AssegnaIngredientePizzaCodice 12,12

CREATE PROCEDURE EliminaIngredientePizzaCodice
@codice_pizza int,
@codice_ingrediente int
AS
BEGIN
	BEGIN TRY
		DELETE FROM IngredientePizza 
		WHERE Codice_Ingrediente = @codice_ingrediente AND 
			Codice_Pizza = @codice_pizza
	END TRY
	BEGIN CATCH
		SELECT ERROR_LINE(),ERROR_MESSAGE(),ERROR_SEVERITY()
	END CATCH
END



CREATE PROCEDURE IncrementaPrezzoPizzaPerIngrediente
@codice_ingrediente int
AS
BEGIN
	BEGIN TRY

	UPDATE Pizza SET Prezzo += 0.1*Prezzo
	WHERE Codice_Pizza in
	(
		SELECT p.Codice_Pizza
		FROM IngredientePizza i
		JOIN Pizza p
		ON p.Codice_Pizza = i.Codice_Pizza
		WHERE i.Codice_Ingrediente = @codice_ingrediente
	)
	END TRY
	BEGIN CATCH
		SELECT ERROR_LINE(),ERROR_MESSAGE(),ERROR_SEVERITY()
	END CATCH
END

select * from pizza
select * from Ingrediente

exec IncrementaPrezzoPizzaPerIngrediente 23





-- FUNZIONI





CREATE FUNCTION ListinoPizze()
RETURNS TABLE
AS
RETURN 
	SELECT p.Nome, p.Prezzo
	FROM Pizza p


SELECT * 
FROM dbo.ListinoPizze() F
ORDER BY F.Nome




CREATE FUNCTION ListinoPizzePerIngrediente
(
	@codice_Ingrediente INT
)
RETURNS TABLE
AS
RETURN 
	SELECT p.Nome, p.Prezzo
	FROM Pizza p
	JOIN IngredientePizza ingP
	ON p.Codice_Pizza = ingP.Codice_Pizza
	WHERE ingP.Codice_Ingrediente = @codice_Ingrediente


SELECT *
FROM dbo.ListinoPizzePerIngrediente(23)



CREATE FUNCTION ListinoPizzeSenzaIngrediente
(
	@codice_Ingrediente INT
)
RETURNS TABLE
AS
RETURN 
	SELECT DISTINCT p.Nome, p.Prezzo
	FROM Pizza p
	JOIN IngredientePizza ingP
	ON p.Codice_Pizza = ingP.Codice_Pizza
	WHERE p.Nome NOT IN
	(
		SELECT f.Nome
		FROM dbo.ListinoPizzePerIngrediente(@codice_Ingrediente) f
	)


SELECT *
FROM dbo.ListinoPizzeSenzaIngrediente(1)





CREATE FUNCTION ContaPizzePerIngrediente
(
	@codice_Ingrediente INT
)
RETURNS int
AS BEGIN
	DECLARE @nrPizze int
	SELECT @nrPizze = COUNT(*)
	FROM dbo.ListinoPizzePerIngrediente(@codice_Ingrediente)

	RETURN @nrPizze
END


select dbo.ContaPizzePerIngrediente(1)




CREATE FUNCTION ContaPizzeSenzaIngrediente
(
	@codice_Ingrediente INT
)
RETURNS int
AS BEGIN
	DECLARE @nrPizze int
	SELECT @nrPizze = COUNT(*)
	FROM dbo.ListinoPizzeSenzaIngrediente(@codice_Ingrediente)

	RETURN @nrPizze
END


select dbo.ContaPizzeSenzaIngrediente(1)




CREATE FUNCTION ContaIngredientiPerPizza
(
	@codice_Pizza INT
)
RETURNS int
AS BEGIN
	DECLARE @nrIngredienti int
	SELECT @nrIngredienti = COUNT(*)
	FROM 
	(
		SELECT *
		FROM IngredientePizza ingP
		WHERE ingP.Codice_Pizza = @codice_Pizza
	) Ingredienti

	RETURN @nrIngredienti
END


select dbo.ContaIngredientiPerPizza(3)




CREATE VIEW Menu 
AS
(
	SELECT p.Nome, p.Prezzo, i.Nome 'Ingrediente'
	FROM Pizza p
	JOIN IngredientePizza ingP
	ON p.Codice_Pizza = ingP.Codice_Pizza
	JOIN Ingrediente i
	ON i.Codice_Ingrediente = ingP.Codice_Ingrediente
	GROUP BY p.Nome, i.Nome, p.Prezzo
)

SELECT *
FROM Menu

