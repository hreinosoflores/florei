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
@Table(name = "tb_cuentas_bancarias")
public class CuentaBancaria implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(length = 100, nullable = false)
	private String nombreBanco;

	@Column(length = 100, nullable = false)
	private String nroCuenta;

	@Column(columnDefinition = "text")
	private String comentarios;

	@Embedded
	private Auditoria auditoria;

	public CuentaBancaria(String nombreBanco, String nroCuenta, String comentarios) {
		this.nombreBanco = nombreBanco;
		this.nroCuenta = nroCuenta;
		this.comentarios = comentarios;
	}

	public CuentaBancaria() {
	}

	public CuentaBancaria(String nombreBanco, String nroCuenta, String comentarios, Auditoria auditoria) {
		this.nombreBanco = nombreBanco;
		this.nroCuenta = nroCuenta;
		this.comentarios = comentarios;
		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNombreBanco() {
		return nombreBanco;
	}

	public void setNombreBanco(String nombreBanco) {
		this.nombreBanco = nombreBanco;
	}

	public String getNroCuenta() {
		return nroCuenta;
	}

	public void setNroCuenta(String nroCuenta) {
		this.nroCuenta = nroCuenta;
	}

	public String getComentarios() {
		return comentarios;
	}

	public void setComentarios(String comentarios) {
		this.comentarios = comentarios;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
