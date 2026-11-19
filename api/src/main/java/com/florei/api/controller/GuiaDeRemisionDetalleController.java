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

import com.florei.api.model.GuiaDeRemisionDetalle;
import com.florei.api.repo.GuiaDeRemisionDetalleRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/guiaderemisiondetalle")
@CrossOrigin
public class GuiaDeRemisionDetalleController {
	@Autowired
	private GuiaDeRemisionDetalleRepository guiaDeRemisionDetalleRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, guiaDeRemisionDetalleRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody GuiaDeRemisionDetalle guiaDeRemisionDetalle) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			guiaDeRemisionDetalle.getAuditoria().setActivo(true);
			guiaDeRemisionDetalle.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, guiaDeRemisionDetalleRepository.save(guiaDeRemisionDetalle));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody GuiaDeRemisionDetalle guiaDeRemisionDetalle) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			guiaDeRemisionDetalle.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, guiaDeRemisionDetalleRepository.save(guiaDeRemisionDetalle));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			guiaDeRemisionDetalleRepository.deleteById(id);
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
			GuiaDeRemisionDetalle guiaDeRemisionDetalle = guiaDeRemisionDetalleRepository.findById(id).orElse(null);
			if (guiaDeRemisionDetalle != null) {
				guiaDeRemisionDetalle.getAuditoria().setActivo(!guiaDeRemisionDetalle.getAuditoria().getActivo());
				guiaDeRemisionDetalle.getAuditoria().setFechaModificacion(new Date());
				guiaDeRemisionDetalle.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, guiaDeRemisionDetalleRepository.save(guiaDeRemisionDetalle));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
