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
@Table(name = "tb_personas_naturales")
public class PersonaNatural implements Serializable {

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

	@Column(columnDefinition = "char(8)", unique = true)
	private String dni;

	@Column(columnDefinition = "char(11)", unique = true)
	private String ruc;

	@Column(length = 100, nullable = false)
	private String nombres;

	@Column(length = 100)
	private String apellidos;

	@Embedded
	private Auditoria auditoria;

	public PersonaNatural() {
	}

	public PersonaNatural(Persona persona, String dni, String ruc, String nombres, String apellidos) {
		this.persona = persona;
		this.dni = dni;
		this.ruc = ruc;
		this.nombres = nombres;
		this.apellidos = apellidos;

	}

	public PersonaNatural(Persona persona, String dni, String ruc, String nombres, String apellidos,
			Auditoria auditoria) {
		this.persona = persona;
		this.dni = dni;
		this.ruc = ruc;
		this.nombres = nombres;
		this.apellidos = apellidos;

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

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}

	public String getRuc() {
		return ruc;
	}

	public void setRuc(String ruc) {
		this.ruc = ruc;
	}

	public String getNombres() {
		return nombres;
	}

	public void setNombres(String nombres) {
		this.nombres = nombres;
	}

	public String getApellidos() {
		return apellidos;
	}

	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
