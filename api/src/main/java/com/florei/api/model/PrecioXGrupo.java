package com.florei.api.model;

import java.io.Serializable;
import java.math.BigDecimal;

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
@Table(name = "tb_precio_grupo_producto")
public class PrecioXGrupo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(optional = false)
	@JoinColumn(name = "idGrupoVenta")
	private GrupoVenta grupoVenta;

	@ManyToOne(optional = false)
	@JoinColumn(name = "idProducto")
	private Producto producto;

	@Column(precision = 8, scale = 2)
	private BigDecimal valorSoles;

	@Embedded
	private Auditoria auditoria;

	public PrecioXGrupo(GrupoVenta grupoVenta, Producto producto, BigDecimal valorSoles) {
		this.grupoVenta = grupoVenta;
		this.producto = producto;
		this.valorSoles = valorSoles;
	}

	public PrecioXGrupo() {
	}

	public PrecioXGrupo(GrupoVenta grupoVenta, Producto producto, BigDecimal valorSoles, Auditoria auditoria) {
		this.grupoVenta = grupoVenta;
		this.producto = producto;
		this.valorSoles = valorSoles;
		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public GrupoVenta getGrupoVenta() {
		return grupoVenta;
	}

	public void setGrupoVenta(GrupoVenta grupoVenta) {
		this.grupoVenta = grupoVenta;
	}

	public Producto getProducto() {
		return producto;
	}

	public void setProducto(Producto producto) {
		this.producto = producto;
	}

	public BigDecimal getValorSoles() {
		return valorSoles;
	}

	public void setValorSoles(BigDecimal valorSoles) {
		this.valorSoles = valorSoles;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
