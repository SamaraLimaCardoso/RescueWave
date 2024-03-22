#ifndef FUNCIONARIO_H
#define FUNCIONARIO_H

class Funcionario {

private:
	int matriculaFuncionario;
	char senha[32];
    int idOrgao;

public:
    void solicitarAlerta();

	void acessarHistorico();

	void atualizarAlerta();

	bool verifLogin();
};

#endif