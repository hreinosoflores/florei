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

import com.florei.api.model.FacturaDetalle;
import com.florei.api.repo.FacturaDetalleRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/facturadetalle")
@CrossOrigin
public class FacturaDetalleController {

	@Autowired
	private FacturaDetalleRepository facturaDetalleRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, facturaDetalleRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody FacturaDetalle facturaDetalle) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			facturaDetalle.getAuditoria().setActivo(true);
			facturaDetalle.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, facturaDetalleRepository.save(facturaDetalle));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody FacturaDetalle facturaDetalle) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			facturaDetalle.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, facturaDetalleRepository.save(facturaDetalle));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			facturaDetalleRepository.deleteById(id);
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
			FacturaDetalle facturaDetalle = facturaDetalleRepository.findById(id).orElse(null);
			if (facturaDetalle != null) {
				facturaDetalle.getAuditoria().setActivo(!facturaDetalle.getAuditoria().getActivo());
				facturaDetalle.getAuditoria().setFechaModificacion(new Date());
				facturaDetalle.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, facturaDetalleRepository.save(facturaDetalle));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
