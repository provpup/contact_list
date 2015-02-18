DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
  firstname varchar(40) NOT NULL,
  lastname  varchar(40) NOT NULL,
  email     varchar(40) NOT NULL,
  id        serial NOT NULL PRIMARY KEY
);

INSERT INTO contacts (firstname, lastname, email) VALUES 
('Alan','Hodges','alan.hodges@abcdef.com'),
('Dylan','May','dylan.may@abcdef.com'),
('Jennifer','Churchill','jennifer.churchill@abcdef.com'),
('Warren','Pullman','warren.pullman@abcdef.com'),
('Colin','Jackson','colin.jackson@abcdef.com'),
('Colin','Chapman','colin.chapman@abcdef.com'),
('Michael','Clarkson','michael.clarkson@abcdef.com'),
('Lily','Slater','lily.slater@abcdef.com'),
('Sam','Hudson','sam.hudson@abcdef.com'),
('Sonia','Harris','sonia.harris@abcdef.com'),
('Emma','Paterson','emma.paterson@abcdef.com'),
('Sue','Jackson','sue.jackson@abcdef.com'),
('Connor','Hughes','connor.hughes@abcdef.com'),
('Theresa','North','theresa.north@abcdef.com'),
('Stephen','Gibson','stephen.gibson@abcdef.com'),
('Zoe','Harris','zoe.harris@abcdef.com'),
('Steven','Short','steven.short@abcdef.com'),
('Dorothy','Walsh','dorothy.walsh@abcdef.com'),
('Boris','Bell','boris.bell@abcdef.com'),
('Victor','Mitchell','victor.mitchell@abcdef.com');

