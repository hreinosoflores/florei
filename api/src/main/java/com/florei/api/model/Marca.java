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
import com.florei.api.util.Global;

@Entity
@Table(name = "tb_marcas")
public class Marca implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(length = 100, nullable = false)
	private String descripcion;

	@Column(length = 100, nullable = false, unique = true)
	private String slug;

	@ManyToOne
	@JoinColumn(name = "idImagen")
	private Imagen imagen;

	@Embedded
	private Auditoria auditoria;

	public Marca() {
	}

	public Marca(String descripcion, Imagen imagen) {
		this.descripcion = descripcion;
		this.imagen = imagen;
		this.slug = Global.toSlug(descripcion);
	}

	public Marca(String descripcion, String slug, Imagen imagen, Auditoria auditoria) {
		this.descripcion = descripcion;
		this.slug = slug;
		this.imagen = imagen;
		this.auditoria = auditoria;
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

	public String getSlug() {
		return slug;
	}

	public void setSlug(String slug) {
		this.slug = slug;
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
