'''
Mudanca de nome na coluna TYPE para TYPE_SHOW, porque "type" e uma palavra reservada do mysql, alem de mudar seu tipo para STRING.
	
		df.rename(columns={'type': 'type_show'}, inplace=True)		# mudar nome da coluna
		df['type_show'] = df['type_show'].astype(str)			# mudar tipo da coluna para STRING


'''