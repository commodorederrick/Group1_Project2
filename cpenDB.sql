PGDMP                         z            cpenDB    14.2    14.2 (    "           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            #           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            $           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            %           1262    24791    cpenDB    DATABASE     l   CREATE DATABASE "cpenDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE "cpenDB";
                postgres    false            ?            1259    24813    course    TABLE     ?   CREATE TABLE public.course (
    "courseName" character varying(100) NOT NULL,
    "courseCode" character varying(100) NOT NULL
);
    DROP TABLE public.course;
       public         heap    postgres    false            ?            1259    24818 
   enrolls_in    TABLE     s   CREATE TABLE public.enrolls_in (
    "studID" bigint NOT NULL,
    "courseCode" character varying(100) NOT NULL
);
    DROP TABLE public.enrolls_in;
       public         heap    postgres    false            ?            1259    24823    is_assigned    TABLE     x   CREATE TABLE public.is_assigned (
    "lecturerID" bigint NOT NULL,
    "courseCode" character varying(100) NOT NULL
);
    DROP TABLE public.is_assigned;
       public         heap    postgres    false            ?            1259    24798    lecturer    TABLE     ?   CREATE TABLE public.lecturer (
    "fName" character varying(100) NOT NULL,
    "lName" character varying(100) NOT NULL,
    "lecturerID" bigint NOT NULL,
    sex "char" NOT NULL
);
    DROP TABLE public.lecturer;
       public         heap    postgres    false            &           0    0    TABLE lecturer    COMMENT     ?   COMMENT ON TABLE public.lecturer IS 'Stores lecturer details';
          public          postgres    false    210            ?            1259    24897    lecturer_lecturerID_seq    SEQUENCE     ?   ALTER TABLE public.lecturer ALTER COLUMN "lecturerID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."lecturer_lecturerID_seq"
    START WITH 156895
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    210            ?            1259    24792    student    TABLE     ?   CREATE TABLE public.student (
    "fName" character varying(100) NOT NULL,
    "lName" character varying(100) NOT NULL,
    "studID" bigint NOT NULL,
    fees numeric(10,2) NOT NULL,
    sex "char" NOT NULL,
    "amountPaid" numeric(10,2) DEFAULT 0.00
);
    DROP TABLE public.student;
       public         heap    postgres    false            '           0    0    TABLE student    COMMENT     A   COMMENT ON TABLE public.student IS 'Stores student details....';
          public          postgres    false    209            ?            1259    24872    student_studID_seq    SEQUENCE     ?   ALTER TABLE public.student ALTER COLUMN "studID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."student_studID_seq"
    START WITH 10904196
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209            ?            1259    24803    teaches    TABLE     `   CREATE TABLE public.teaches (
    "studID" bigint NOT NULL,
    "lecturerID" bigint NOT NULL
);
    DROP TABLE public.teaches;
       public         heap    postgres    false            ?            1259    24808    teachingAssistant    TABLE     ?   CREATE TABLE public."teachingAssistant" (
    "fName" character varying(100) NOT NULL,
    "lName" character varying(100) NOT NULL,
    sex "char" NOT NULL,
    "lecturerID" bigint NOT NULL,
    "courseCode" character varying(100) NOT NULL
);
 '   DROP TABLE public."teachingAssistant";
       public         heap    postgres    false            (           0    0    TABLE "teachingAssistant"    COMMENT     F   COMMENT ON TABLE public."teachingAssistant" IS 'Stores T.As details';
          public          postgres    false    212                      0    24813    course 
   TABLE DATA           <   COPY public.course ("courseName", "courseCode") FROM stdin;
    public          postgres    false    213   ?.                 0    24818 
   enrolls_in 
   TABLE DATA           <   COPY public.enrolls_in ("studID", "courseCode") FROM stdin;
    public          postgres    false    214   ?/                 0    24823    is_assigned 
   TABLE DATA           A   COPY public.is_assigned ("lecturerID", "courseCode") FROM stdin;
    public          postgres    false    215   ,0                 0    24798    lecturer 
   TABLE DATA           G   COPY public.lecturer ("fName", "lName", "lecturerID", sex) FROM stdin;
    public          postgres    false    210   ?0                 0    24792    student 
   TABLE DATA           V   COPY public.student ("fName", "lName", "studID", fees, sex, "amountPaid") FROM stdin;
    public          postgres    false    209   $1                 0    24803    teaches 
   TABLE DATA           9   COPY public.teaches ("studID", "lecturerID") FROM stdin;
    public          postgres    false    211   ?3                 0    24808    teachingAssistant 
   TABLE DATA           `   COPY public."teachingAssistant" ("fName", "lName", sex, "lecturerID", "courseCode") FROM stdin;
    public          postgres    false    212   k4       )           0    0    lecturer_lecturerID_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public."lecturer_lecturerID_seq"', 156901, true);
          public          postgres    false    217            *           0    0    student_studID_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."student_studID_seq"', 10904232, true);
          public          postgres    false    216                       2606    24879    course course_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY ("courseCode");
 <   ALTER TABLE ONLY public.course DROP CONSTRAINT course_pkey;
       public            postgres    false    213            y           2606    24802    lecturer lecturerID_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT "lecturerID_pkey" PRIMARY KEY ("lecturerID");
 D   ALTER TABLE ONLY public.lecturer DROP CONSTRAINT "lecturerID_pkey";
       public            postgres    false    210            ?           2606    24875    enrolls_in rel_enrolls_in_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.enrolls_in
    ADD CONSTRAINT rel_enrolls_in_pkey PRIMARY KEY ("courseCode", "studID");
 H   ALTER TABLE ONLY public.enrolls_in DROP CONSTRAINT rel_enrolls_in_pkey;
       public            postgres    false    214    214            ?           2606    24886     is_assigned rel_is_assigned_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.is_assigned
    ADD CONSTRAINT rel_is_assigned_pkey PRIMARY KEY ("lecturerID", "courseCode");
 J   ALTER TABLE ONLY public.is_assigned DROP CONSTRAINT rel_is_assigned_pkey;
       public            postgres    false    215    215            {           2606    24807    teaches rel_teaches_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.teaches
    ADD CONSTRAINT rel_teaches_pkey PRIMARY KEY ("studID", "lecturerID");
 B   ALTER TABLE ONLY public.teaches DROP CONSTRAINT rel_teaches_pkey;
       public            postgres    false    211    211            w           2606    24797    student student_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY ("studID");
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public            postgres    false    209            }           2606    24877 (   teachingAssistant teachingAssistant_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY public."teachingAssistant"
    ADD CONSTRAINT "teachingAssistant_pkey" PRIMARY KEY ("courseCode", "lecturerID");
 V   ALTER TABLE ONLY public."teachingAssistant" DROP CONSTRAINT "teachingAssistant_pkey";
       public            postgres    false    212    212            ?           2606    24880    enrolls_in courseCode_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.enrolls_in
    ADD CONSTRAINT "courseCode_fkey" FOREIGN KEY ("courseCode") REFERENCES public.course("courseCode") NOT VALID;
 F   ALTER TABLE ONLY public.enrolls_in DROP CONSTRAINT "courseCode_fkey";
       public          postgres    false    213    214    3199            ?           2606    24887    is_assigned courseCode_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.is_assigned
    ADD CONSTRAINT "courseCode_fkey" FOREIGN KEY ("courseCode") REFERENCES public.course("courseCode") NOT VALID;
 G   ALTER TABLE ONLY public.is_assigned DROP CONSTRAINT "courseCode_fkey";
       public          postgres    false    215    213    3199            ?           2606    24892 !   teachingAssistant courseCode_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."teachingAssistant"
    ADD CONSTRAINT "courseCode_fkey" FOREIGN KEY ("courseCode") REFERENCES public.course("courseCode") NOT VALID;
 O   ALTER TABLE ONLY public."teachingAssistant" DROP CONSTRAINT "courseCode_fkey";
       public          postgres    false    212    213    3199            ?           2606    24833    teaches lecturerID_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.teaches
    ADD CONSTRAINT "lecturerID_fkey" FOREIGN KEY ("lecturerID") REFERENCES public.lecturer("lecturerID") NOT VALID;
 C   ALTER TABLE ONLY public.teaches DROP CONSTRAINT "lecturerID_fkey";
       public          postgres    false    211    210    3193            ?           2606    24842 !   teachingAssistant lecturerID_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public."teachingAssistant"
    ADD CONSTRAINT "lecturerID_fkey" FOREIGN KEY ("lecturerID") REFERENCES public.lecturer("lecturerID") NOT VALID;
 O   ALTER TABLE ONLY public."teachingAssistant" DROP CONSTRAINT "lecturerID_fkey";
       public          postgres    false    3193    212    210            ?           2606    24867    is_assigned lecturerID_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.is_assigned
    ADD CONSTRAINT "lecturerID_fkey" FOREIGN KEY ("lecturerID") REFERENCES public.lecturer("lecturerID") NOT VALID;
 G   ALTER TABLE ONLY public.is_assigned DROP CONSTRAINT "lecturerID_fkey";
       public          postgres    false    210    215    3193            ?           2606    24828    teaches studID_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.teaches
    ADD CONSTRAINT "studID_fkey" FOREIGN KEY ("studID") REFERENCES public.student("studID") NOT VALID;
 ?   ALTER TABLE ONLY public.teaches DROP CONSTRAINT "studID_fkey";
       public          postgres    false    211    3191    209            ?           2606    24857    enrolls_in studID_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.enrolls_in
    ADD CONSTRAINT "studID_fkey" FOREIGN KEY ("studID") REFERENCES public.student("studID") NOT VALID;
 B   ALTER TABLE ONLY public.enrolls_in DROP CONSTRAINT "studID_fkey";
       public          postgres    false    3191    214    209               ?   x?M?1?0?????KM]K??A)7??x?$p???7?J??^N?%i?1?B?d?J?&?i??/N??xD??gPH&!/???e1d??E??z?h????D?/w?L??0Ɖߚ,t?a??V?W??(?B??'???|S e???A<*!?(I=         x   x?m?;
?0 ?zs
/?$Q?G)A?D;??mVĝ??????!??)??59????L????(#?>?\??????]??xO?I?Sx
O?)<??U??<?g??U=?????sx???.??0?o!         K   x?345??4?tst?S020?2??8??|c?Ƈ?[????%
??? ?7??9C݃???t??-?b???? ?>?         ?   x?-?A?0????????KLu!1?n?Њ?&?j?????򿼃?ȉ?`?"?e?8?z?1j#?Z??\g1?S`hҘpc>??;8????ea??+ٝ?e?'????R?f??H??,3?v????s??V)??/?         ?  x?m??n?@????? ?Iå?k?iK?
?7c<?+ۻt?[?>}Ǆ?D?.?;?;3??Z????4?ɍE?&?q4y?????h$?"?F?m0G?"???`?? ~d?/ƕ?????A???&??S? W'?OFN?OL??	@$??V?7??|r?/????k?.??I?<ڻV?Q??-???????P1??~?c]?x???b?1??9h??ؔ?q?:?|???3???? ?2???龆}?a[???C????}?O?"j?/MK3???? g?ו??đ?d??ԣ}7,?uiA?????T??E]?rs? 72????3??? */??gPQ/?????Z?;?i??????????*?? ?FյҘk??)?L2?4?9?/X?&?g?#?ߒ?P1f*f?U?I?w???s?G?m?????z'?r???9??l?N?=?rs4?U????`sAKꔜ?|SoC????4nQC?hBz#nI??ȿ?5?ê???rq??[tR71????ҋ}#㝂??D????????ˆ??q?&?ab??:z̡?y?
?g??xveXSB??1?z?????l?r?&[?~q????c?S?o???2?7/?y?-????ws?߲G?M|t?#=35?+??????]?,??X??;??7???ڒ,y?d???lo???X_???
??[ԇP?m????`?????         p   x?]ͱBAD??lĭ????? ?$?p??t~??UG??,?ၽ?L??>?>?>?????_?k|?????7???|?????????????d??Zp?{?~??;"~W{?         ?   x?}?A?0????)???-a? ????M? %?V?퍚?;?ߟ??5???9P?L?,O`??:RB?ٛG?>??i??)Ǐ?X?9?#4?=-?v???aݎ?l??3??*?j?e??hg???Bp???F-???????TDJ????C?o??F??/?2     