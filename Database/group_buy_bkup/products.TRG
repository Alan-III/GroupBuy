TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER `group_buy`.`products_BEFORE_DELETE` BEFORE DELETE ON `products` FOR EACH ROW\nBEGIN\n/*ΔΙΑΓΡΑΑΦΗ ΤΩΝ ΕΠΙΘΥΜΙΩΝ ΠΟΥ ΕΧΟΥΝ ΑΥΤΟΝ ΤΟΝ ΚΨΔΙΚΟ ΠΡΟΙΟΝΤΟΣ*/\nDELETE FROM mywish where productCode=old.productCode;\ndelete from notifications where productCode=old.productCode;\n\n/* Διαγραφή των προιόντων που αναζητήθηκαν ΚΑΤΑ ΣΕΙΡΑ ΒΑΡΥΤΗΤΑΣ ΜΗΝΑΣ-ΕΒΔΟΜΑΔΑ-ΗΜΕΡΑ-ΑΝΑΖΗΤΗΣΕΙΣ */\ndelete from monthlyResults where productCode= old.productCode;\ndelete from weeklyResults where productCode= old.productCode;\ndelete from dailyResults where productCode= old.productCode;\ndelete from searchdetails where productCode= old.productCode;\n\nEND'
sql_modes=1098907648
definers='root@localhost'
client_cs_names='utf8mb4'
connection_cl_names='utf8mb4_general_ci'
db_cl_names='utf8mb4_general_ci'
created=1686164602304346
