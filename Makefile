figure-transactions.pdf: figure-transactions.R transactions.csv
	R --no-save < $<
