package com.florei.api.model.view;

import java.util.List;

public class ContactosWeb {
	private Long idTrab;
	private String nombres;
	private String cargo;
	private List<String> celulares;
	private List<String> fijos;
	private List<String> emails;

	public Long getIdTrab() {
		return idTrab;
	}

	public void setIdTrab(Long idTrab) {
		this.idTrab = idTrab;
	}

	public String getNombres() {
		return nombres;
	}

	public void setNombres(String nombres) {
		this.nombres = nombres;
	}

	public String getCargo() {
		return cargo;
	}

	public void setCargo(String cargo) {
		this.cargo = cargo;
	}

	public List<String> getCelulares() {
		return celulares;
	}

	public void setCelulares(List<String> celulares) {
		this.celulares = celulares;
	}

	public List<String> getFijos() {
		return fijos;
	}

	public void setFijos(List<String> fijos) {
		this.fijos = fijos;
	}

	public List<String> getEmails() {
		return emails;
	}

	public void setEmails(List<String> emails) {
		this.emails = emails;
	}

	public ContactosWeb() {
	}

	public ContactosWeb(Long idTrab, String nombres, String cargo, List<String> celulares, List<String> fijos,
			List<String> emails) {
		this.idTrab = idTrab;
		this.nombres = nombres;
		this.cargo = cargo;
		this.celulares = celulares;
		this.fijos = fijos;
		this.emails = emails;
	}

}
