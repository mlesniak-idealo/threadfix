package com.denimgroup.threadfix.data.dao.hibernate;

import com.denimgroup.threadfix.data.dao.AbstractObjectDao;
import com.denimgroup.threadfix.data.dao.ScheduledJobDao;
import com.denimgroup.threadfix.data.entities.ScheduledJob;

import org.hibernate.SessionFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

/**
 * Created by dzabdi88 on 8/15/14.
 */

@Repository
public abstract class HibernateScheduledJobDao<S extends ScheduledJob> extends AbstractObjectDao<S> implements ScheduledJobDao<S> {

    @Autowired
    public HibernateScheduledJobDao(SessionFactory sessionFactory) {
        super(sessionFactory);
    }

    @Override
    public void delete(S scheduledJob) {
        sessionFactory.getCurrentSession().delete(scheduledJob);
    }

}
