/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.techdao;

import com.entities.Category;
import com.entities.Post;
import java.sql.Connection;
import java.util.*;
import java.sql.*;
/**
 *
 * @author admin
 */
public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> list = new ArrayList<>();

        try {

            String q = "select * from categories";
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(q);
            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Category c = new Category(cid, name, description);
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean savePost(Post p) {
        boolean f = false;
        try {

            String q = "insert into posts(ptitle,pcontent,pcode,ppic,catid,userid) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, p.getPtitle());
            pstmt.setString(2, p.getPcontent());
            pstmt.setString(3, p.getPcode());
            pstmt.setString(4, p.getPpic());
            pstmt.setInt(5, p.getCatid());
            pstmt.setInt(6, p.getUserid());
            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
    //    get all the posts
    public List<Post> getAllPosts() {

        List<Post> list = new ArrayList<>();
        //fetch all the post
        try {

            PreparedStatement p = con.prepareStatement("select * from posts order by pid desc");

            ResultSet set = p.executeQuery();

            while (set.next()) {

                int pid = set.getInt("pid");
                String pTitle = set.getString("ptitle");
                String pContent = set.getString("pcontent");
                String pCode = set.getString("pcode");
                String pPic = set.getString("ppic");
                Timestamp date = set.getTimestamp("pdate");
                int catId = set.getInt("catid");
                int userId = set.getInt("userid");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Post> getPostByCatId(int catId) {
        List<Post> list = new ArrayList<>();
        //fetch all post by id
        //fetch all the post
        try {

            PreparedStatement p = con.prepareStatement("select * from posts where catid=?");
            p.setInt(1, catId);
            ResultSet set = p.executeQuery();

            while (set.next()) {

                int pid = set.getInt("pid");
                String pTitle = set.getString("ptitle");
                String pContent = set.getString("pcontent");
                String pCode = set.getString("pcode");
                String pPic = set.getString("ppic");
                Timestamp date = set.getTimestamp("pdate");

                int userId = set.getInt("userid");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Post getPostByPostId(int postId) {
        Post post = null;
        String q = "select * from posts where pid=?";
        try {
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1, postId);

            ResultSet set = p.executeQuery();

            if (set.next()) {

                int pid = set.getInt("pid");
                String pTitle = set.getString("ptitle");
                String pContent = set.getString("pcontent");
                String pCode = set.getString("pcode");
                String pPic = set.getString("ppic");
                Timestamp date = set.getTimestamp("pdate");
                int cid=set.getInt("catid");
                int userId = set.getInt("userid");
                post = new Post(pid, pTitle, pContent, pCode, pPic, date, cid, userId);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }

}
