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
@Table(name = "tb_luces")
public class Luz implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@OneToOne(optional = false)
	@JoinColumn(name = "idProducto", unique = true)
	private Producto producto;

	private Integer potencia;

	private Integer flujoLuminoso;

	private Integer duracion;

	@Embedded
	private Auditoria auditoria;

	public Luz() {
	}

	public Luz(Producto producto, Integer potencia, Integer flujoLuminoso, Integer duracion) {
		this.producto = producto;
		this.potencia = potencia;
		this.flujoLuminoso = flujoLuminoso;
		this.duracion = duracion;

	}

	public Luz(Producto producto, Integer potencia, Integer flujoLuminoso, Integer duracion, Auditoria auditoria) {
		this.producto = producto;
		this.potencia = potencia;
		this.flujoLuminoso = flujoLuminoso;
		this.duracion = duracion;

		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Producto getProducto() {
		return producto;
	}

	public void setProducto(Producto producto) {
		this.producto = producto;
	}

	public Integer getPotencia() {
		return potencia;
	}

	public void setPotencia(Integer potencia) {
		this.potencia = potencia;
	}

	public Integer getFlujoLuminoso() {
		return flujoLuminoso;
	}

	public void setFlujoLuminoso(Integer flujoLuminoso) {
		this.flujoLuminoso = flujoLuminoso;
	}

	public Integer getDuracion() {
		return duracion;
	}

	public void setDuracion(Integer duracion) {
		this.duracion = duracion;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
