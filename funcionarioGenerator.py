import random

names = ["Samuel", "Igor", "Gabriela", "Matheus", "Paulo", "Marcos", "Sarah", "Alice", "Bianca", "Yasmin"]
func = ["LIMPEZA", "SUP_LIMPEZA"]
levels = ["J", "P", "S"]

for i in range(10):
    cpf = random.randint(10000000000,99999999999)
    birth = "{}-{}-{}".format(random.randint(1950,2010), (random.randint(1,13) if ), random.randint(1,29))
    fun = random.choice(func)
    niv = random.choice(levels)
    sup_cpf = random.randint(10000000000,99999999999)
    if fun == "SUP_LIMPEZA":    sup_cpf = "NULL"
    print("INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('{}', '{}', '{}', '{}', '{}', {});".format(cpf, birth, names[i], fun, niv, sup_cpf))
