package com.florei.api.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.florei.api.util.Auditoria;

@Entity
@Table(name = "tb_documento_detalles")
public class DocumentoDetalle implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(optional = false)
	@JoinColumn(name = "idDocumento")
	private Documento documento;

	@ManyToOne(optional = false)
	@JoinColumn(name = "idProducto")
	private Producto producto;

	@Column(nullable = false)
	private Integer nroLinea;

	@Column(nullable = false)
	private Integer cantidadUnidades;

	@Embedded
	private Auditoria auditoria;

	public DocumentoDetalle() {
	}

	public DocumentoDetalle(Documento documento, Producto producto, Integer nroLinea, Integer cantidadUnidades) {
		this.documento = documento;
		this.producto = producto;
		this.nroLinea = nroLinea;
		this.cantidadUnidades = cantidadUnidades;

	}

	public DocumentoDetalle(Documento documento, Producto producto, Integer nroLinea, Integer cantidadUnidades,
			Auditoria auditoria) {
		this.documento = documento;
		this.producto = producto;
		this.nroLinea = nroLinea;
		this.cantidadUnidades = cantidadUnidades;

		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Documento getDocumento() {
		return documento;
	}

	public void setDocumento(Documento documento) {
		this.documento = documento;
	}

	public Producto getProducto() {
		return producto;
	}

	public void setProducto(Producto producto) {
		this.producto = producto;
	}

	public Integer getNroLinea() {
		return nroLinea;
	}

	public void setNroLinea(Integer nroLinea) {
		this.nroLinea = nroLinea;
	}

	public Integer getCantidadUnidades() {
		return cantidadUnidades;
	}

	public void setCantidadUnidades(Integer cantidadUnidades) {
		this.cantidadUnidades = cantidadUnidades;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
