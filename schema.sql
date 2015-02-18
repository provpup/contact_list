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

/*
INSERT INTO contacts (firstname, lastname, email) VALUES
('Deirdre','Sanderson','deirdre.sanderson@abcdef.com'),
('Donna','Watson','donna.watson@abcdef.com'),
('Emma','Hodges','emma.hodges@abcdef.com'),
('Victor','Langdon','victor.langdon@abcdef.com'),
('Jake','Scott','jake.scott@abcdef.com'),
('Steven','Butler','steven.butler@abcdef.com'),
('Adrian','Hughes','adrian.hughes@abcdef.com'),
('Stephen','Wallace','stephen.wallace@abcdef.com'),
('Sean','Newman','sean.newman@abcdef.com'),
('Nathan','Ross','nathan.ross@abcdef.com'),
('Piers','Hemmings','piers.hemmings@abcdef.com'),
('Anne','Mathis','anne.mathis@abcdef.com'),
('Ian','MacLeod','ian.macleod@abcdef.com'),
('Jane','Lawrence','jane.lawrence@abcdef.com'),
('Fiona','Poole','fiona.poole@abcdef.com'),
('Kimberly','Graham','kimberly.graham@abcdef.com'),
('Donna','Nolan','donna.nolan@abcdef.com'),
('Joshua','Manning','joshua.manning@abcdef.com'),
('Warren','Scott','warren.scott@abcdef.com'),
('Victoria','Tucker','victoria.tucker@abcdef.com'),
('Yvonne','Peters','yvonne.peters@abcdef.com'),
('Felicity','Wright','felicity.wright@abcdef.com'),
('Andrea','McGrath','andrea.mcgrath@abcdef.com'),
('Jason','Greene','jason.greene@abcdef.com'),
('Lily','Wallace','lily.wallace@abcdef.com'),
('Sally','Parr','sally.parr@abcdef.com'),
('Abigail','Metcalfe','abigail.metcalfe@abcdef.com'),
('Jake','Hudson','jake.hudson@abcdef.com'),
('Chloe','Dowd','chloe.dowd@abcdef.com'),
('Jason','McDonald','jason.mcdonald@abcdef.com'),
('Elizabeth','James','elizabeth.james@abcdef.com'),
('Jacob','Thomson','jacob.thomson@abcdef.com'),
('Kevin','Lawrence','kevin.lawrence@abcdef.com'),
('Lauren','Howard','lauren.howard@abcdef.com');
*/