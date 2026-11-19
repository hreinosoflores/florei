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

import com.florei.api.model.Cable;
import com.florei.api.repo.CableRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/cable")
@CrossOrigin
public class CableController {
	@Autowired
	private CableRepository cableRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, cableRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Cable cable) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cable.getAuditoria().setActivo(true);
			cable.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, cableRepository.save(cable));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Cable cable) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cable.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, cableRepository.save(cable));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cableRepository.deleteById(id);
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
			Cable cable = cableRepository.findById(id).orElse(null);
			if (cable != null) {
				cable.getAuditoria().setActivo(!cable.getAuditoria().getActivo());
				cable.getAuditoria().setFechaModificacion(new Date());
				cable.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, cableRepository.save(cable));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
