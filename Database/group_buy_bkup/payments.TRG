TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER `group_buy`.`payments_AFTER_INSERT` AFTER INSERT ON `payments` FOR EACH ROW\nBEGIN\n    /* ΚΑΘΕ ΦΟΡΑ ΠΟΥ Η ΕΤΑΙΡΙΑ ΠΛΗΡΩΝΕΙ ΤΗΝ ΣΥΝΔΡΟΜΗ ΤΗΣ ΠΡΟΣ ΤΗΝ ΣΕΛΙΔΑ, ΕΠΙΛΕΓΕΙ ΚΑΙ ΑΛΛΑΖΕΙ ΤΟ LEVEL ΤΗΣ */\n    IF (NEW.level IS NOT NULL) THEN\n        UPDATE subscriptions SET level = NEW.level WHERE email = NEW.business.email;\n        UPDATE business SET balance = balance - NEW.amount;\n        UPDATE admin SET balance = balance + NEW.amount;\n    END IF;\n\n    /* ΜΕΤΑ ΤΗΝ ΕΚΤΕΛΕΣΗ ΤΗΣ ΠΛΗΡΩΜΗΣ, ΜΕΤΑΒΑΛΩ ΚΑΙ ΤΟ ΣΥΝΟΛΙΚΟ ΥΠΟΛΟΙΠΟ ΤΗΣ ΕΠΙΧΕΙΡΗΣΗ */\n    IF (NEW.businessEmail IS NULL) THEN\n        IF (NEW.InOut = \'in\') THEN\n            UPDATE user SET balance = balance + NEW.amount;\n        ELSEIF (NEW.InOut = \'out\') THEN\n            UPDATE user SET balance = balance - NEW.amount;\n        END IF;\n    END IF;\n\n    /* ΜΕΤΑ ΤΗΝ ΕΚΤΕΛΕΣΗ ΤΗΣ ΠΛΗΡΩΜΗΣ, ΜΕΤΑΒΑΛΩ ΚΑΙ ΤΟ ΣΥΝΟΛΙΚΟ ΥΠΟΛΟΙΠΟ ΤΟΥ ΧΡΗΣΤΗ */\n    IF (NEW.userEmail IS NULL) THEN\n        IF (NEW.InOut = \'in\') THEN\n            UPDATE business SET balance = balance + NEW.amount;\n        ELSEIF (NEW.InOut = \'out\') THEN\n            UPDATE business SET balance = balance - NEW.amount;\n        END IF;\n    END IF;\nEND'
sql_modes=1098907648
definers='root@localhost'
client_cs_names='utf8mb4'
connection_cl_names='utf8mb4_general_ci'
db_cl_names='utf8mb4_general_ci'
created=1686174213801422
