package com.florei.api.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.florei.api.util.Auditoria;

@Entity
@Table(name = "tb_contactos")
public class Contacto implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(length = 100, nullable = false, unique = true)
	private String dato;

	@Column(nullable = false)
	private Short tipoDato;

	@Embedded
	private Auditoria auditoria;

	public Contacto() {
	}

	public Contacto(String dato, Short tipoDato) {
		this.dato = dato;
		this.tipoDato = tipoDato;
	}

	public Contacto(String dato, Short tipoDato, Auditoria auditoria) {
		this.dato = dato;
		this.tipoDato = tipoDato;
		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDato() {
		return dato;
	}

	public void setDato(String dato) {
		this.dato = dato;
	}

	public Short getTipoDato() {
		return tipoDato;
	}

	public void setTipoDato(Short tipoDato) {
		this.tipoDato = tipoDato;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
