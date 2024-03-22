#ifndef ADMINISTRADOR_H
#define ADMINISTRADOR_H

class Administrador {

private:
	int id;
	string nomeAdm;

public:
	void cadastrarFuncionario();

	void removerFuncionario();

	void verificarFuncionario();
};

#endif
