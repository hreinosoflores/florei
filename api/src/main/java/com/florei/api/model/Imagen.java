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
@Table(name = "tb_imagenes")
public class Imagen implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(length = 100, nullable = false)
	private String nombreExt;

	@Column(length = 100, nullable = false, unique = true)
	private String idGoogleDrive;

	@Column(length = 200, nullable = false)
	private String secureUrlCloudinary;

	@Embedded
	private Auditoria auditoria;

	public Imagen() {
	}

	public Imagen(String nombreExt, String idGoogleDrive, String secureUrlCloudinary) {
		this.nombreExt = nombreExt;
		this.idGoogleDrive = idGoogleDrive;
		this.secureUrlCloudinary = secureUrlCloudinary;
	}

	public Imagen(String nombreExt, String idGoogleDrive, String secureUrlCloudinary, Auditoria auditoria) {
		this.nombreExt = nombreExt;
		this.idGoogleDrive = idGoogleDrive;
		this.secureUrlCloudinary = secureUrlCloudinary;
		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNombreExt() {
		return nombreExt;
	}

	public void setNombreExt(String nombreExt) {
		this.nombreExt = nombreExt;
	}

	public String getIdGoogleDrive() {
		return idGoogleDrive;
	}

	public void setIdGoogleDrive(String idGoogleDrive) {
		this.idGoogleDrive = idGoogleDrive;
	}

	public String getSecureUrlCloudinary() {
		return secureUrlCloudinary;
	}

	public void setSecureUrlCloudinary(String secureUrlCloudinary) {
		this.secureUrlCloudinary = secureUrlCloudinary;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
