package com.florei.api.model;

import java.io.Serializable;

import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.florei.api.util.Auditoria;

@Entity
@Table(name = "tb_clientes_juridicos")
public class ClienteJuridico implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@OneToOne(optional = false)
	@JoinColumn(name = "idPersonaJuridica", unique = true)
	private PersonaJuridica peJuridico;

	@Embedded
	private Auditoria auditoria;

	public ClienteJuridico() {
	}

	public ClienteJuridico(PersonaJuridica peJuridico) {
		this.peJuridico = peJuridico;
	}

	public ClienteJuridico(PersonaJuridica peJuridico, Auditoria auditoria) {
		this.peJuridico = peJuridico;
		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public PersonaJuridica getPeJuridico() {
		return peJuridico;
	}

	public void setPeJuridico(PersonaJuridica peJuridico) {
		this.peJuridico = peJuridico;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
