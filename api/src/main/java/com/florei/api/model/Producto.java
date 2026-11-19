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
@Table(name = "tb_productos")
public class Producto implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(optional = false)
	@JoinColumn(name = "idSubCategoria")
	private SubCategoria subCategoria;

	@Column(length = 100, nullable = false)
	private String descripcion;

	private Integer cantidadxCaja;

	private Integer stockActual;

	private Integer garantia;

	@Column(precision = 8, scale = 2)
	private BigDecimal pesoUnitario;

	@ManyToOne
	@JoinColumn(name = "idMarca")
	private Marca marca;

	@ManyToOne
	@JoinColumn(name = "idImagen")
	private Imagen imagen;

	@Embedded
	private Auditoria auditoria;

	public Producto() {
	}

	public Producto(SubCategoria subCategoria, String descripcion, Integer cantidadxCaja, Integer stockActual,
			Integer garantia, BigDecimal pesoUnitario, Marca marca, Imagen imagen) {
		this.subCategoria = subCategoria;
		this.descripcion = descripcion;
		this.cantidadxCaja = cantidadxCaja;
		this.stockActual = stockActual;
		this.garantia = garantia;
		this.pesoUnitario = pesoUnitario;
		this.marca = marca;
		this.imagen = imagen;
	}

	public Producto(SubCategoria subCategoria, String descripcion, Integer cantidadxCaja, Integer stockActual,
			Integer garantia, BigDecimal pesoUnitario, Marca marca, Imagen imagen, Auditoria auditoria) {
		this.subCategoria = subCategoria;
		this.descripcion = descripcion;
		this.cantidadxCaja = cantidadxCaja;
		this.stockActual = stockActual;
		this.garantia = garantia;
		this.pesoUnitario = pesoUnitario;
		this.marca = marca;
		this.imagen = imagen;
		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public SubCategoria getSubCategoria() {
		return subCategoria;
	}

	public void setSubCategoria(SubCategoria subCategoria) {
		this.subCategoria = subCategoria;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public Integer getCantidadxCaja() {
		return cantidadxCaja;
	}

	public void setCantidadxCaja(Integer cantidadxCaja) {
		this.cantidadxCaja = cantidadxCaja;
	}

	public Integer getStockActual() {
		return stockActual;
	}

	public void setStockActual(Integer stockActual) {
		this.stockActual = stockActual;
	}

	public Integer getGarantia() {
		return garantia;
	}

	public void setGarantia(Integer garantia) {
		this.garantia = garantia;
	}

	public BigDecimal getPesoUnitario() {
		return pesoUnitario;
	}

	public void setPesoUnitario(BigDecimal pesoUnitario) {
		this.pesoUnitario = pesoUnitario;
	}

	public Marca getMarca() {
		return marca;
	}

	public void setMarca(Marca marca) {
		this.marca = marca;
	}

	public Imagen getImagen() {
		return imagen;
	}

	public void setImagen(Imagen imagen) {
		this.imagen = imagen;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}
}
