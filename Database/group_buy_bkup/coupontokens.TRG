TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER `group_buy`.`coupontokens_AFTER_UPDATE` AFTER UPDATE ON `coupontokens` FOR EACH ROW\nBEGIN\ndeclare price DECIMAL(10,2);\ndeclare group_size int;\n\nSELECT  groupSize into @group_size from offers where offerID=new.offerID;\n\nif ((SELECT count(email) from coupontokens where offerID=new.offerID)=@group_size AND NEW.DATE=NULL ) THEN\nUPDATE OFFERS SET active=0 where offerID=NEW.offerID;\nEND IF;\n\nIF (new.date is not null) then \n\nselect couponPrice INTO @price FROM offers where offerID=old.offerID;\n\nUPDATE users SET couponAmount = couponAmount - @price, balance=balance+price where email=old.email;\nupdate business set balance=balance + @price;\ninsert into payments (businessEmail,userEmail,details,date,amount) values ((select email from offers where offerID=new.offerID),new.email,new.token,new.date,@price);\n\nend if;\nEND' 'CREATE DEFINER=`root`@`localhost` TRIGGER `coupontokens_BEFORE_DELETE` BEFORE DELETE ON `coupontokens` FOR EACH ROW BEGIN\n/*ΟΤΑΝ ΔΙΑΓΡΑΦΕΤΑΙ ΤΟ ΚΟΥΠΟΝΙ ΠΡΕΠΕΙ ΝΑ ΕΠΙΣΤΡΑΦΟΥΝ ΤΑ ΧΡΗΜΑΤΑ ΣΤΟΥΣ USER*/\n\ndeclare price DECIMAL(10,2);\n\nselect couponPrice INTO @price FROM offers where offerID=old.offerID;\n\nUPDATE users SET couponAmount = couponAmount - price, balance=balance+price where email=old.email;\n\nEND'
sql_modes=1098907648 1098907648
definers='root@localhost' 'root@localhost'
client_cs_names='utf8mb4' 'utf8mb4'
connection_cl_names='utf8mb4_general_ci' 'utf8mb4_general_ci'
db_cl_names='utf8mb4_general_ci' 'utf8mb4_general_ci'
created=1686171018223159 1686166416396401
