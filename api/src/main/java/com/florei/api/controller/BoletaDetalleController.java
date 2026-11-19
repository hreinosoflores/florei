package com.florei.api.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.florei.api.model.BoletaDetalle;
import com.florei.api.repo.BoletaDetalleRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/boletadetalle")
@CrossOrigin
public class BoletaDetalleController {
	@Autowired
	private BoletaDetalleRepository boletaDetalleRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, boletaDetalleRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody BoletaDetalle boletaDetalle) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			boletaDetalle.getAuditoria().setActivo(true);
			boletaDetalle.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, boletaDetalleRepository.save(boletaDetalle));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody BoletaDetalle boletaDetalle) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			boletaDetalle.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, boletaDetalleRepository.save(boletaDetalle));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			boletaDetalleRepository.deleteById(id);
			Global.resultOK(result, id);
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PatchMapping("/activo/{usu}/{id}")
	public Map<String, Object> toggleActivo(@PathVariable Long usu, @PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			BoletaDetalle boletaDetalle = boletaDetalleRepository.findById(id).orElse(null);
			if (boletaDetalle != null) {
				boletaDetalle.getAuditoria().setActivo(!boletaDetalle.getAuditoria().getActivo());
				boletaDetalle.getAuditoria().setFechaModificacion(new Date());
				boletaDetalle.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, boletaDetalleRepository.save(boletaDetalle));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
