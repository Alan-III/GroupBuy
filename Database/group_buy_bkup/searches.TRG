TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER `searches_AFTER_INSERT` AFTER INSERT ON `searches` FOR EACH ROW BEGIN\nif (new.email <> null)  then #ΣΥΣΧΕΤΗΣΗ IP & EMAIL ΜΕΤΑ ΤΗΝ ΠΡΩΤΗ ΕΓΓΡΑΦΗ ΑΝΑΖΗΤΗΣΗΣ ΓΙΑ ΤΟΝ ΧΡΗΣΤΗ ΠΟΥ ΕΙΝΑΙ ΣΥΝΔΕΔΕΜΕΝΟΣ\n update searches set email=new.email where ip=new.ip; \n update dailyResults set email=ne.emai where ip=new.ip;\n end if;\nEND'
sql_modes=1168113696
definers='root@localhost'
client_cs_names='utf8mb4'
connection_cl_names='utf8_general_ci'
db_cl_names='utf8mb4_general_ci'
created=1686144863130532
