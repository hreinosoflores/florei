package com.florei.api.model;

import java.io.Serializable;

import javax.persistence.Column;
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
@Table(name = "tb_personas_juridicas")
public class PersonaJuridica implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@OneToOne(optional = false)
	@JoinColumn(name = "idPersona", unique = true)
	private Persona persona;

	@Column(columnDefinition = "char(11)", unique = true)
	private String ruc;

	@Column(length = 200, nullable = false, unique = true)
	private String razonSocial;

	@Embedded
	private Auditoria auditoria;

	public PersonaJuridica() {
	}

	public PersonaJuridica(Persona persona, String ruc, String razonSocial) {
		this.persona = persona;
		this.ruc = ruc;
		this.razonSocial = razonSocial;

	}

	public PersonaJuridica(Persona persona, String ruc, String razonSocial, Auditoria auditoria) {
		this.persona = persona;
		this.ruc = ruc;
		this.razonSocial = razonSocial;

		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Persona getPersona() {
		return persona;
	}

	public void setPersona(Persona persona) {
		this.persona = persona;
	}

	public String getRuc() {
		return ruc;
	}

	public void setRuc(String ruc) {
		this.ruc = ruc;
	}

	public String getRazonSocial() {
		return razonSocial;
	}

	public void setRazonSocial(String razonSocial) {
		this.razonSocial = razonSocial;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
