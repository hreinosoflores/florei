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
@Table(name = "tb_grupos_venta")
public class GrupoVenta implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(length = 100, nullable = false)
	private String descripcion;

	@Embedded
	private Auditoria auditoria;

	public GrupoVenta(String descripcion) {
		this.descripcion = descripcion;
	}

	public GrupoVenta(String descripcion, Auditoria auditoria) {
		this.descripcion = descripcion;
		this.auditoria = auditoria;
	}

	public GrupoVenta() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
