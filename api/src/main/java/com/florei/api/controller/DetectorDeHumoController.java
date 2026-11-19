package com.florei.api.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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

import com.florei.api.model.DetectorDeHumo;
import com.florei.api.repo.DetectorDeHumoRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/detectordehumo")
@CrossOrigin
public class DetectorDeHumoController {
	private DetectorDeHumoRepository detectorDeHumoRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, detectorDeHumoRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody DetectorDeHumo detectorDeHumo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			detectorDeHumo.getAuditoria().setActivo(true);
			detectorDeHumo.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, detectorDeHumoRepository.save(detectorDeHumo));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody DetectorDeHumo detectorDeHumo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			detectorDeHumo.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, detectorDeHumoRepository.save(detectorDeHumo));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			detectorDeHumoRepository.deleteById(id);
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
			DetectorDeHumo detectorDeHumo = detectorDeHumoRepository.findById(id).orElse(null);
			if (detectorDeHumo != null) {
				detectorDeHumo.getAuditoria().setActivo(!detectorDeHumo.getAuditoria().getActivo());
				detectorDeHumo.getAuditoria().setFechaModificacion(new Date());
				detectorDeHumo.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, detectorDeHumoRepository.save(detectorDeHumo));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
