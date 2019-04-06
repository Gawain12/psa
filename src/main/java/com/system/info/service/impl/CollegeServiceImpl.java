package com.system.info.service.impl;

import com.system.info.dao.CollegeExample;
import com.system.info.dao.CollegeMapper;
import com.system.info.entity.College;
import com.system.info.service.CollegeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Jacey on 2017/6/30.
 */
@Service
public class CollegeServiceImpl implements CollegeService {

    @Autowired(required=false)
    private CollegeMapper collegeMapper;

    public List<College> finAll() throws Exception {
        CollegeExample collegeExample = new CollegeExample();
        CollegeExample.Criteria criteria = collegeExample.createCriteria();

        criteria.andCollegeidIsNotNull();


        return collegeMapper.selectByExample(collegeExample);
    }
}
