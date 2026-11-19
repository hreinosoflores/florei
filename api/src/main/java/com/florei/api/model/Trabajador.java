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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.florei.api.util.Auditoria;

@Entity
@Table(name = "tb_trabajadores")
public class Trabajador implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@OneToOne(optional = false)
	@JoinColumn(name = "idPersonaNatural", unique = true)
	private PersonaNatural peNatural;

	@Column(name = "usr", length = 100, nullable = false, unique = true)
	private String user;

	@Column(nullable = false)
	private String password;

	@ManyToOne(optional = false)
	@JoinColumn(name = "idCargo")
	private Cargo cargo;

	@Embedded
	private Auditoria auditoria;

	public Trabajador() {
	}

	public Trabajador(PersonaNatural peNatural, String user, String password, Cargo cargo) {
		this.peNatural = peNatural;
		this.user = user;
		this.password = password;
		this.cargo = cargo;
	}

	public Trabajador(PersonaNatural peNatural, String user, String password, Cargo cargo, Auditoria auditoria) {
		this.peNatural = peNatural;
		this.user = user;
		this.password = password;
		this.cargo = cargo;
		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public PersonaNatural getPeNatural() {
		return peNatural;
	}

	public void setPeNatural(PersonaNatural peNatural) {
		this.peNatural = peNatural;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Cargo getCargo() {
		return cargo;
	}

	public void setCargo(Cargo cargo) {
		this.cargo = cargo;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
